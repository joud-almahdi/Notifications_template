import 'dart:convert';

import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http/http.dart' as https;
import 'interceptor.dart';

class Http {
  Http._();

  static Http get http => Http._();

  final _client = InterceptedClient.build(
    interceptors: [Interceptor()],
  );



  //GET request
  Future<https.Response> getRequest({
    required String? endpoint,
    Map<String, String>? headers,
  }) async {
    return await _client.get(
      Uri.parse(''),
      headers: headers,
    );
  }

  //POST request
  Future<https.Response> postRequest({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    return await _client.post(
      Uri.parse('https://fcm.googleapis.com/v1/projects/notificationtemplate-f0f84/messages:send'),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  //PUT request
  Future<https.Response> updateRequest({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    return await _client.put(
      Uri.parse(''),
      headers: headers,
      body: jsonEncode(body),
    );
  }

//Delete request
  Future<https.Response> deleteRequest({
    required String endpoint,
  }) async {
    return await _client.delete(Uri.parse(''));
  }

}