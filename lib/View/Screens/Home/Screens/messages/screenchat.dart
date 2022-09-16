import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/ListeMessages.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/appbar.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/buttonSendMessage.dart';
import '../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
class ScreenCHat extends StatefulWidget {
  final idclien , idmsg, imageprofile, name , token;
    ScreenCHat({Key? key,required this.idclien,required this.idmsg,required this.imageprofile,required this.name,required this.token}) : super(key: key);
  @override
  State<ScreenCHat> createState() => _ScreenCHatState();
}

class _ScreenCHatState extends State<ScreenCHat> {
var controllerMessanger= Get.put(ControllerMessanger());
    FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;

    firbasecloudMessaging_listeners(){
_firebaseMessaging.getToken().then((value) {
 print("token is :"+value.toString());
 
 setState(() {
   
 });
});
  }
TextEditingController _controllertext=TextEditingController();
@override
  void initState() {
    firbasecloudMessaging_listeners();
     controllerMessanger.retundata(widget. idclien);
    super.initState();
  }
  var idm;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: appbarmessage(context,widget. name,widget. imageprofile,widget. idclien,widget. token),
      body: Stack(
        children:  [
        listmessages(idm,widget.idmsg),
        buttonSendMessage(_controllertext, controllerMessanger,widget.idclien,widget.idmsg,widget.token,),
        ],
      ),
    );
  }

  


}


 