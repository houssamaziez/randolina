// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {

final time, details, username , photouser, urlImage, likes, comentr,uid , id;


  Post(   {required this.uid,required this.id,
    required this.time,required this.details,required this.username,required this.photouser,required this.urlImage,required this.likes,required this.comentr, });

Map <String , dynamic> tojeson ()=>{
"time":time,
"details":details,
"username":username,
"photouser":photouser,
"urlImage":urlImage,
"likes":likes,
"comentr":comentr,
"uid":uid,
"id":id,


};


static Post fromsnap(DocumentSnapshot snap){
      var snapshot=snap.data() as Map <String , dynamic>;
      return Post(
        time:snapshot["time"] ,
        details:snapshot["details"] ,
        username: snapshot["username"],
       photouser:  snapshot["photouser"],
       urlImage: snapshot["urlImage"],
       uid: snapshot["uid"],
        likes: snapshot["likes"],
        comentr: snapshot["comentr"],
        id: snapshot["id"],

        );
     }
}