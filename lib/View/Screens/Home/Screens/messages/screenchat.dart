import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenAllMessage.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/ListeMessages.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/appbar.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/buttonSendMessage.dart';
import 'package:shaky_animated_listview/scroll_animator.dart';
import '../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../const.dart';
class ScreenCHat extends StatefulWidget {
  final idclien , idmsg, imageprofile, name;
    ScreenCHat({Key? key,required this.idclien,required this.idmsg,required this.imageprofile,required this.name}) : super(key: key);
  @override
  State<ScreenCHat> createState() => _ScreenCHatState();
}

class _ScreenCHatState extends State<ScreenCHat> {
var controllerMessanger= Get.put(ControllerMessanger());

TextEditingController _controllertext=TextEditingController();
@override
  void initState() {
     controllerMessanger.retundata(widget. idclien);
    super.initState();
  }
  var idm;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: appbarmessage(context,widget. name,widget. imageprofile),
      body: Stack(
        children:  [
        listmessages(idm,widget.idmsg),
        buttonSendMessage(_controllertext, controllerMessanger,widget.idclien,widget.idmsg),
        ],
      ),
    );
  }

  


}


 