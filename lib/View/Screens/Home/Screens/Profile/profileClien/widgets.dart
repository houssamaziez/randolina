
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenchat.dart';
import 'package:randolina/const.dart';

  iconback(BuildContext context,String idclien, imageprofile,name) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(onPressed: (){
Navigator.pop(context);
}, icon:const Icon(Icons.arrow_back,color:Colors.white, )),
        ),
         Spacer(), 
         Padding(
           padding: const EdgeInsets.only(right: 5, top: 20),
           child: IconButton(onPressed: (){
            Get.to( ScreenCHat(idclien: idclien.toString() , idmsg: "0",imageprofile:imageprofile , name: name,));
           }, icon:idclien==firebaseAuth.currentUser!.uid?Container(): Icon(Icons.message_rounded, color: Colors.white,)),
         ),
      ],
    );
  }
