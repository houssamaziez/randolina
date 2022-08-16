// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Ivent {

final time,price,distance,nombresplaces,datedubte,datefine, details, username ,destination, photouser, urlImage, participate,uid , id, images;


  Ivent( {
    
   required this. price  ,required this.distance,required this.nombresplaces,required this.datedubte,required this.datefine,
    required this.destination, required this.images,    required this.uid,required this.id,
    required this.time,required this.details,required this.username,required this.photouser,required this.urlImage,required this.participate, });

Map <String , dynamic> tojeson ()=>
{
"time":time,
"price":price,
"distance":distance,
"nombresplaces":nombresplaces,
"datedubte":datedubte,
"datefine":datefine,
"destination":destination,
"details":details,
"username":username,
"photouser":photouser,
"urlImage":urlImage,
"participate":participate,
"price":price,
"uid":uid,
"id":id,
"images":images,
};
static Ivent fromsnap(DocumentSnapshot snap){
      var snapshot=snap.data() as Map <String , dynamic>;
      return Ivent(

        datedubte:snapshot["datedubte"] ,
        datefine:snapshot["datefine"] ,
        distance:snapshot["distance"] ,
        nombresplaces:snapshot["nombresplaces"] ,
        destination:snapshot["destination"] ,
        time:snapshot["time"] ,
        details: snapshot["details"] ,
        username: snapshot["username"],
        photouser: snapshot["photouser"],
        urlImage: snapshot["urlImage"],
        uid: snapshot["uid"],
        participate: snapshot["participate"],
        price: snapshot["price"],
        id: snapshot["id"],
        images: snapshot["images"],
        );
     }
}