import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:notificationtemplate/api/http.dart';
import 'package:notificationtemplate/api/notifications_model.dart';

final firestore = FirebaseFirestore.instance;

class NotificationsServices {
  notificationFuntion() async {
    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAipJQ6CU:APA91bGBiyXZpqdCWStJRUzX8TNIihQJvZz28-p5vqDrDeKNGDnTqQhkY93BfjoBajMsODGKrVnb0A-kkyBlcATCUxc01aIe9dhhNBxT695cBBaS7kHKT6Y3pVz-wGqoGSoQkCPBaECg'
      },
      body: jsonEncode(<String, dynamic>{
        "to":
            "e9zRjrQTa0JOrqkkN0J0gj:APA91bEmeh9SVcHoIoR7qKpw257-DYy68kRTsAH_XTe5KlsMyOccir33Ygh2YfMfcf-yffxprrgysJXFbwgc74tRK9A09lxTk0cPpr7dOcW7B6KeQ7IA_uKZROIclXrfHyUOm48ijiwm",
        "notification": {"title": "This", "body": "This works"}
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(response.body.toString());
    }
  }
}
