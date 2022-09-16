
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:randolina/Model/message.dart';
import 'package:randolina/const.dart';

class ControllerMessanger extends GetxController{
bool islodingemsg= false;
waitsendopject(bol){
islodingemsg=bol;
update();
}


  sendmessageToAll({
    required users,required idmsg,
    required msg, isfolew=true,required token
  })async
  {   
    var _uid= firebaseAuth.currentUser!.uid;
    
 int len=    Random().nextInt(100000000);
 int lenc=    Random().nextInt(100000000);
print(msg);

if (isfolew==true) {
  if (idmsg=="0") {
print("waiting ...$users");

  QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').orderBy('time', descending: true).get();
  List rslt=data.docs.where((element) => element["users"].contains(users) &&element["users"].contains(_uid)) .toList();
print(rslt.length);

//  user mahoch fi data base 
if (rslt.length==0) {
     Listmessage mseg= Listmessage(
  msg: msg,
  sendidmsg:_uid ,
  msgid: "$_uid $lenc",
  time: DateTime.now().toString(),
   users: [_uid,users],
 );
 firestor.collection('Massenger').doc("$_uid $lenc").set(mseg.toJson()).then((value) =>print("object"));
  sendmessages(idmsg: "$_uid $lenc", msg:msg );
             
//  User kayn fi data base 
} else {
  firestor.collection('Massenger').doc(rslt[0]["msgid"]).update({
  "msg":msg,"sendidmsg":_uid,
  "time":DateTime.now().toString(),
 }).then((value) =>print('object'));
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
  "msg":msg,"sendidmsg":_uid,
  "time":DateTime.now().toString(),
 });
sendmessages(idmsg:idmsg, msg:msg );

   } else {
     Listmessage mseg= Listmessage(
  msg: msg,sendidmsg: _uid,
  msgid: "$_uid $len",
  time: DateTime.now().toString(),
   users: [_uid,users ],
 );
 firestor.collection('Massenger').doc("$_uid $len").set(mseg.toJson());
sendmessages(idmsg:"$_uid $len", msg:msg );

   }
 

}
} else {
  relaodfolow=true;
  update();

List d= await addfollow(users);
  if (d.length==0) {
    
       Listmessage mseg= Listmessage(
  msg: msg,sendidmsg:_uid ,
  msgid: "$_uid $lenc",
  time: DateTime.now().toString(),
   users: [_uid,users],
 );
 firestor.collection('Massenger').doc("$_uid $lenc").set(mseg.toJson()).then((value) =>print("object"));
  
  }
await virffollow(users);

  relaodfolow=false;
  update();
}


}

deletemsgeFollow({
    required users, 
   
  })async{
  var uidd=firebaseAuth.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').get();
  List rslt=data.docs.where((element) => element["users"].contains(users) &&element["users"].contains(uidd)) .toList();
    await firestor.collection('Massenger').doc(rslt[0]["msgid"]).delete();
    Get.back();

}
cleanrsltdatamesage(){
  rsltdatamesage= [];
  // update();
}
 late List rsltdatamesage= [];
retundata(users, )async{
  var uidd=firebaseAuth.currentUser!.uid;

   QuerySnapshot<Map<String, dynamic>> data;
 data=await firestor.collection('Massenger').orderBy('time', descending: true).get().then((value) => 
 data=value);
   rsltdatamesage=data.docs.where((element) => element["users"].contains(users) &&element["users"].contains(uidd)) .toList();
update();
if (rsltdatamesage.length!=0) {
 print(rsltdatamesage.length);
} else {
  
}
}


getdata()async{
var rslt;
QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').orderBy('time', descending: true).get();
rslt=data.docs.where((element) => element["users"].contains(firebaseAuth.currentUser!.uid)) .toList();
return rslt;
}
List numfollowid= [];

getNUMBERLfoollow(id)async{
List _rsltfollow= [];
List _rsltfollowid= [];

QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').get();
_rsltfollow=data.docs.where((element) => element["users"].contains(id)) .toList();
_rsltfollow.forEach((element) {
  element["users"].forEach((element) {
  _rsltfollowid.add(element);
  
  });
  
  });
 _rsltfollowid= _rsltfollowid.where((element) => element!=id).toList();
   print(_rsltfollowid.length);
numfollowid=_rsltfollowid;
update();
}

  getdatauser(uid)async{
var data;
data =await firestor.collection("User").doc(uid).get();
return data ;
}

List v=[];
 
 bool isfolow=false;
 bool relaodfolow=false;


addfollow(users)async{
  var uidd=firebaseAuth.currentUser!.uid;
  
  QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').get();
  List rslt=data.docs.where((element) => element["users"].contains(users) && element["users"].contains( uidd)) .toList();
         cleanrsltdatamesage();
  
  return rslt;
}
virffollow(users)async{
  var uidd=firebaseAuth.currentUser!.uid;
  QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').orderBy('time', descending: true).get();
  List rslt=data.docs.where((element) => element["users"].contains(users) &&element["users"].contains(uidd)) .toList();
getmsegeNosee(users);
if (rslt.length==0) {
  isfolow=false;
  update();
}else{
  isfolow=true;
  update();


}
}


sendmessages({msg ,idmsg}){
  var _uid=firebaseAuth.currentUser!.uid;
 int len=    Random().nextInt(100000000);

  firestor.collection('Massenger').doc(idmsg).collection("messages").doc("$_uid$len").set({
"sendidmsg":_uid,
    "message":msg,
    "time":DateTime.now(),
    "uid":_uid,
    "msgid":"$_uid$len",

  }).then((value) => null);
    
  }





int  msgevu=0;
var msgeviewvu=0;

getvumsg()async{
  List _listt= [];
List rslt;
QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').orderBy('time', descending: true).get();
rslt=data.docs.where((element) => element["users"].contains(firebaseAuth.currentUser!.uid)) .toList();
             
rslt.forEach((element) {

if (firebaseAuth.currentUser!.uid != element["sendidmsg"]) {
             _listt.add(element["sendidmsg"]);
             
           }
          messgaenosee.write('noseemsge', _listt.length);

});
print("length of message no see :"+_listt.length.toString());
}
getmsegeNosee(id)async{
QuerySnapshot<Map<String, dynamic>> data=await firestor.collection('Massenger').orderBy('time', descending: true).get();
List c=data.docs.where((element) => element["users"].contains(id)) .toList();
msgevu=c.length;
update();
}











 FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;
   String token1="";
    firbasecloudMessaging_listeners(){
_firebaseMessaging.getToken().then((value) {
  firestor.collection('User').doc(firebaseAuth.currentUser!.uid).update({
'token':value.toString()
  });
 print("token is :"+value.toString());
 token1=value.toString();
 
 update();
});
  }

@override
  void onInit() {
  firbasecloudMessaging_listeners();
    super.onInit();
  }


}