import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body:${message.notification?.body}');
  print('message.data: ${message.data}');
}

class FirebaseApi {
  //1- create the firebase messaging instance
  final firebaseMessaging = FirebaseMessaging.instance;
  //2-for storing device token
  final db = FirebaseFirestore.instance;

  //For Android channel for local notification
  final androidChannel = AndroidNotificationChannel(
      'notifications_channel', 'notifications_channel_notification',
      description: 'this channel is used for important notifications',
      importance: Importance.defaultImportance);
  final localNotifications = FlutterLocalNotificationsPlugin();

  //For handling local notifications and create the notification channel
  Future initLocalNotifications() async {
    DarwinInitializationSettings ios = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          print(body);
        });
    const android =
        AndroidInitializationSettings('@drawable/launch_background');
    final settings = InitializationSettings(android: android, iOS: ios);
    await localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
    });
    final platform = localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }

//For initialization of notifications when app first opens. should be called in main function in main.dart
  Future<void> initNotifications() async {
    //recieve permission from the device to allow the app to send notifications
    await firebaseMessaging.requestPermission();
    //Token should be saved somewhere like get storage for later use. It changes with every installation
    final token = await firebaseMessaging.getToken();

    print('token : ${token}');

    //For receiving notifications when the app is in the background
    //handleBackgroundMessage should be global and not defined in the class
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    initLocalNotifications();
    //listens to foreground notifications
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) {
        return;
      }
      localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  androidChannel.id, androidChannel.name,
                  channelDescription: androidChannel.description),
              iOS: const DarwinNotificationDetails()),
          payload: jsonEncode(message.toMap()));
    });
  }

  saveDeviceController() async {
    String id = '123456';
    String? theToken = await firebaseMessaging.getToken();
    if (theToken != null) {
      var theEnteredToken =
          db.collection('users').doc(id).collection('tokens').doc('usertoken');

      await theEnteredToken
          .set({'token:': theToken, 'platform': Platform.operatingSystem});
    }
  }
}
