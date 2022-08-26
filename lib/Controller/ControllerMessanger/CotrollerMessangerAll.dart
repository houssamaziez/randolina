
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:randolina/Model/message.dart';
import 'package:randolina/View/Screens/Registre/screenChos.dart';
import 'package:randolina/const.dart';

import '../../View/Screens/Home/Screens/messages/screenchat.dart';
class ControllerMessanger extends GetxController{
  sendmessageToAll({
    required users,required idmsg,
    required msg
  })async{
    var _uid= firebaseAuth.currentUser!.uid;
 int len=    Random().nextInt(100000000);
 int lenc=    Random().nextInt(100000000);
print(msg);
if (idmsg=="0") {
print("waiting ...$users");

  QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').orderBy('time', descending: true).get();
  List rslt=data.docs.where((element) => element["users"].contains(users)) .toList();
print(rslt.length);

//  user mahoch fi data base 
if (rslt.length==0) {
     Listmessage mseg= Listmessage(
  msg: msg,
  msgid: "$_uid $lenc",
  time: DateTime.now().toString(),
   users: [_uid,users],
 );
 firestor.collection('Massenger').doc("$_uid $lenc").set(mseg.toJson()).then((value) =>Get.to(ScreenCHat(idclien: users, idmsg:  "$_uid $lenc", imageprofile: "imageprofile", name: "name")));
sendmessages(idmsg: "$_uid $lenc", msg:msg );
             
//  User kayn fi data base 
} else {
  firestor.collection('Massenger').doc(rslt[0]["msgid"]).update({
  "msg":msg,
  "time":DateTime.now().toString(),
 }).then((value) =>Get.to( ScreenCHat(idclien: users, idmsg: rslt[0]["msgid"], imageprofile: "imageprofile", name: "name")));
sendmessages(idmsg: rslt[0]["msgid"], msg:msg );
}
}else{






QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').orderBy('time', descending: true).get();
var iscont=data.docs.where((element) => element["users"].contains(firebaseAuth.currentUser!.uid)) .toList();
       bool iscontBdd= false;
    if (idmsg!="0") {
      for (var i = 0; i < data.docs.length; i++) {
          if (data.docs[i]["msgid"]==idmsg) {
            iscontBdd=true;
     }
           if(iscontBdd=true) break;
      }
    }
   if (iscontBdd==true) {
 firestor.collection('Massenger').doc(idmsg).update({
  "msg":msg,
  "time":DateTime.now().toString(),
 }).then((value) => Get.snackbar('complet', "djfnsjfndsf"));
sendmessages(idmsg:idmsg, msg:msg );

   } else {
     Listmessage mseg= Listmessage(
  msg: msg,
  msgid: "$_uid $len",
  time: DateTime.now().toString(),
   users: [_uid,users ],
 );
 firestor.collection('Massenger').doc("$_uid $len").set(mseg.toJson()).then((value) => Get.snackbar('complet', "djfnsjfndsf"));
sendmessages(idmsg:"$_uid $len", msg:msg );

   }

 



}
}
retundata(users)async{
   QuerySnapshot<Map<String, dynamic>> data;
 data=await firestor.collection('Massenger').orderBy('time', descending: true).get().then((value) => 
 data=value);
  List rslt=data.docs.where((element) => element["users"].contains(users)) .toList();
print(rslt.length);
}


getdata()async{
var rslt;
QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').orderBy('time', descending: true).get();
rslt=data.docs.where((element) => element["users"].contains(firebaseAuth.currentUser!.uid)) .toList();


return rslt;
}

  getdatauser(uid)async{
var data;
data =await firestor.collection("User").doc(uid).get();
return data ;
}






sendmessages({msg ,idmsg}){
  var _uid=firebaseAuth.currentUser!.uid;
 int len=    Random().nextInt(100000000);

  firestor.collection('Massenger').doc(idmsg).collection("messages").doc("$_uid$len").set({

    "message":msg,
    "time":DateTime.now(),
    "uid":_uid,
    "msgid":"$_uid$len",

  }).then((value) => null);
    
  }

}