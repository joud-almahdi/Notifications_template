
class NotificationsModel {
  String? to;
  Notification? notification;
  Data? data;

  NotificationsModel({this.to, this.notification, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Notification {
  String? title;
  String? body;
  bool? mutableContent;
  String? sound;

  Notification({this.title, this.body, this.mutableContent, this.sound});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    mutableContent = json['mutable_content'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['mutable_content'] = this.mutableContent;
    data['sound'] = this.sound;
    return data;
  }
}

class Data {
  String? url;
  String? dl;

  Data({this.url, this.dl});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['dl'] = this.dl;
    return data;
  }
}