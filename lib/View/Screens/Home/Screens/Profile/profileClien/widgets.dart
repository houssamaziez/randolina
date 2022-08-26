
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenchat.dart';
import 'package:randolina/const.dart';

  iconback(BuildContext context,String idclien, imageprofile,name, data) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Row(
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
             child:  
           idclien==firebaseAuth.currentUser!.uid?Container(): follow(idclien,imageprofile,name) 
           ),
        ],
      ),
    );
  }

    follow(idclien,imageprofile,name) => GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return  cont.isfolow==false?
      
      MaterialButton(height: 30,
        color: Colors.blue,child:cont.relaodfolow==true?Text("leading ..."): Text("follow"),
        onPressed: ()async{

await cont.sendmessageToAll(users: idclien, idmsg: "0", msg: "New follower", isfolew: false);
 await cont.virffollow(idclien);
 cont.retundata( idclien);

      }): IconButton(onPressed: (){
        cont.retundata( idclien);

            Get.to( ScreenCHat(idclien: idclien.toString() ,name: name,
             idmsg:   cont.rsltdatamesage.length==1?
                   cont.rsltdatamesage[0]["msgid"].toString():"0", imageprofile: imageprofile,)
         );
      },   icon: Icon(Icons.message_rounded, color: Colors.white,));
    }
  );
