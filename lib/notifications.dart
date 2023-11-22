import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);
static const route='/notification-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Push'),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Notifications')],
      ),),
    );
  }
}
