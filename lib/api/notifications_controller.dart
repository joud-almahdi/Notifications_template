
import 'package:get/get.dart';

import 'notification_services.dart';

class NotificationsController extends GetxController {
  var isLoading = true.obs;
  var loginmap = <dynamic>{}.obs;
  var notifications = NotificationsServices();

  Future<void> notify() async {
    await notifications.notificationFuntion();
  }
}
