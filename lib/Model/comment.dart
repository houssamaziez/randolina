// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment  {


  final username,time,comment,id , uid,profilephoto,likes;

  Comment({ required this.time,  required this.username,required this.comment,required this.id,required this.uid,required this.profilephoto,required this.likes});




Map <String , dynamic> tojeson ()=>{
"username":username,
"comment":comment,
"profilephoto":profilephoto,
"likes":likes,
"uid":uid,
"id":id,
"time":time,


};


static Comment fromsnap(DocumentSnapshot snap){
      var snapshot=snap.data() as Map <String , dynamic>;
      return Comment(
        profilephoto: snapshot["profilephoto"],
        time:snapshot["time"] ,
        comment:snapshot["comment"] ,
        username: snapshot["username"],
        likes: snapshot["likes"],
        uid: snapshot["uid"],
        id: snapshot["id"],
        );
     }

}