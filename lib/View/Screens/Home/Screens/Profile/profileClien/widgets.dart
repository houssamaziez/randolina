
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenchat.dart';
import 'package:randolina/const.dart';

  iconback(BuildContext context,String idclien, imageprofile,name, token) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Row(
        children: [

           Spacer(), 
           Padding(
             padding: const EdgeInsets.only(right: 5, top: 3),
             child:  
            follow(idclien,imageprofile,name, "") 
           ),
        ],                           
      ),
    );
  }

    follow(idclien,imageprofile,name, token) =>
     GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return  cont.isfolow==false?
      
     Container(): IconButton(onPressed: ()async{
    await    cont.retundata( idclien);

            Get.to( ScreenCHat(
              token: "",
              idclien: idclien.toString() ,name: name,
             idmsg:   cont.rsltdatamesage.length==1?
                   cont.rsltdatamesage[0]["msgid"].toString():"0", imageprofile: imageprofile,)
         );
      },   icon: Icon(Icons.message_rounded, color: Colors.black,));
    }
  );
