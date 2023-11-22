import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'notification_services.dart';

class Interceptor implements InterceptorContract {



  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final token ='ya29.a0AfB_byDBr5WUXrX97DdLyuN_CyCxBsggEuA9aPCJPDviTi_YPGgrK0aHuoAPWTFBkkPwdVC1XilNmdWeps_fXmmoxWA35HyvlifgLB9r75aFGpmrQyL8xABudIVdTC-C2PEiDqoFcl9F9gWMbBlpjvtr9V5UIc0LsMWMaCgYKAZUSARMSFQHGX2MipMTJA1p9Il-ZHjV-zV2V-Q0171';
    data.headers.clear();
    if (token != null) {
      bool hasExpired = JwtDecoder.isExpired(token);
      if (hasExpired) {
        Get.snackbar('You must login', 'message');
      }
      else {
        data.headers['authorization'] = 'Bearer $token';
        data.headers['content-type'] = 'application/json; charset=UTF-8';
        data.headers['accept'] = 'application/json';
        data.headers['Host']='fcm.googleapis.com';
      }
    } else {
      data.headers['content-type'] = 'application/json; charset=UTF-8';
      data.headers['accept'] = 'application/json';
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 402) {

    }
    if (data.statusCode == 404) {

    }
    if (data.statusCode == 405) {

    }
    if (data.statusCode == 422) {

    }
    return data;
  }
}