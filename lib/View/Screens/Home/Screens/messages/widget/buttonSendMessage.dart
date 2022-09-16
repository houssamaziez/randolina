import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../../const.dart';

Align buttonSendMessage(_controllertext,controllerMessanger, idclien, idmsg, token,) {
 String token="";
 String myname="";
   getData(id)async{
 try {
 
  DocumentSnapshot userdocs=await firestor.collection("User").doc(id).get();
  myname=await (userdocs.data()! as Map <String, dynamic>)["name"];
} on Exception catch (e) {
  return;
  // TODO
}
 }  getDataclien(id)async{
 try {
  DocumentSnapshot userdocs=await firestor.collection("User").doc(id).get();
  token=await (userdocs.data()! as Map <String, dynamic>)["token"];
} on Exception catch (e) {
  return;
  // TODO
}
 }
 notificatioon({url,data, msge, username})async{
// var c='c5iWx_oYT5-jQOok-AB38d:APA91bEReWnIWLIj0snmq3wuAZ1oVQZeWW0vMAQ2h6__phvIVF_JagCulGAUg2KFdb2zKcP3DBuSSta-n9wdivu0B48IRpYOM1Om8iRyOMzrWbkf9sCYevByLtJH00BNoDg6xcnfPgKM';
   await getData(firebaseAuth.currentUser!.uid);
await getDataclien(idclien);
print("tooooooooken :"+token);
print("name :"+myname);

 var progress=await http.post(Uri.parse("https://unwrapped-ceremony.000webhostapp.com/phptest/Notification.php"),
 body: {
   'token':token,
  'message':msge ,
'username':myname
 } );
try {
  if (progress.statusCode==200) {
var  responssbody= jsonDecode(    progress.body);
return responssbody;


  } else {
    print(progress.statusCode);
    
    
  }
} catch (e) {
    print(e.toString());
  
}

}  return Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                  ),
                ),
                const SizedBox(width: 15,),
                  Expanded(
                  child:  TextField(controller: _controllertext,
                    decoration:const  InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
                FloatingActionButton(
                  onPressed: ()   {
        notificatioon(msge: _controllertext.text,username: "aziez", data:token );

                    if (_controllertext.text.isNotEmpty) {

controllerMessanger.sendmessageToAll(users:idclien, msg: _controllertext.text, idmsg: idmsg, token:token);
            _controllertext.clear();
   
            }
                  },
                  child: const Icon(Icons.send,color: Colors.white,size: 18,),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ],
              
            ),
          ),
        );
        
  }

 