import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:notificationtemplate/api/http.dart';
import 'package:notificationtemplate/api/notifications_model.dart';

final firestore=FirebaseFirestore.instance;



class NotificationsServices
{
   notificationFuntion() async {
    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'key=AAAAipJQ6CU:APA91bGBiyXZpqdCWStJRUzX8TNIihQJvZz28-p5vqDrDeKNGDnTqQhkY93BfjoBajMsODGKrVnb0A-kkyBlcATCUxc01aIe9dhhNBxT695cBBaS7kHKT6Y3pVz-wGqoGSoQkCPBaECg'
      },
      body: jsonEncode(
          <String, dynamic>{"to": "dzKTvseCQMCICCU0v0yuJr:APA91bFsizPDO1QOCUeJi0wNGK07F4aQew4pkV5ZalOSQjcXZ9SOpuTT63y-ZrVcvlu29VfqTXAwsVR9P_ZxY2x0XdmiSS-bk6fsunK1QG_8ujuEwZ1rKAsOo55tzmiYGYiRtX-HUwak", "notification": {"title":"This","body":"This works"}}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(response.body.toString());
    }
  }
}