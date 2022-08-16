import 'package:flutter/material.dart';

class ScreenUser extends StatelessWidget {
 final title;
  const ScreenUser({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title.toString()),),);
  }
}