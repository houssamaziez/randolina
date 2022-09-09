import 'package:get/get.dart';
 
// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:randolina/Model/store.dart';

import '../Model/event.dart';
import '../const.dart';

class ControllerStor extends  GetxController{
late Rx<File?> _pickedImage;

File? get profilePhoto =>  _pickedImage.value;

getdatativent({required idpost})async{
 DocumentSnapshot userdocs=await firestor.collection("Ivent").doc(idpost).get();
 return (userdocs.data()! as Map <String, dynamic>) ['confermnum'].length;

}

participer( {idpost,required list})async{
  var uid= firebaseAuth.currentUser!.uid;
  DocumentSnapshot<Map<String, dynamic>> post=await  firestor.collection("Ivent").doc(idpost).get();
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();

if ((post.data()!)["participate"].contains(uid)) {
  await  firestor.collection("Ivent").doc(idpost).update({"participate":FieldValue.arrayRemove([uid])});
await  firestor.collection("Ivent").doc(idpost).collection("participate").doc(uid).delete();
 await  firestor.collection("User").doc(uid).collection("participate").doc(idpost).delete();
 
}else{
 await  firestor.collection("Ivent").doc(idpost).collection("participate").doc(uid).set({
    "username": (userdocs.data()! as Map <String, dynamic>)["name"], 
    "uid": (userdocs.data()! as Map <String, dynamic>)["uid"], 
    "phone": (userdocs.data()! as Map <String, dynamic>)["phone"], 
    "photoProfil": (userdocs.data()! as Map <String, dynamic>)["photoProfil"], 
    "wilaya": (userdocs.data()! as Map <String, dynamic>)["wilaya"], 
    "conferm":false
  });
 
  
  await  firestor.collection("Ivent").doc(idpost).update({"participate":FieldValue.arrayUnion([uid])});

   await  firestor.collection("User").doc(uid).collection("participate").doc(idpost).set({
"datedubte":list["datedubte"],
"datefine":list["datefine"] ,
"distance":list["distance"] ,
  "images": list["images"],
  "nombresplaces": list["nombresplaces"],
  "save":list["save"],
    "participate":list["participate"],
  "price":list["price"] ,
    "destination":list["destination"] ,
    "username":list["username"] , 
    "uid":list["uid"]  ,
     "id":list["id"], 
    "details":list["details" ], 
    "urlImage":list["urlImage"] ,
     "photouser":list["photouser"],
      "time":list["time"] 
  } );
  await firestor.collection("User").doc(uid).collection("participate").doc(idpost).update({"participate":FieldValue.arrayUnion([uid])});
  
}

}

seveevent( {idpost,required list})async{
  var uid= firebaseAuth.currentUser!.uid;
  DocumentSnapshot<Map<String, dynamic>> post=await  firestor.collection("Ivent").doc(idpost).get();
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();

if ((post.data()!)["save"].contains(uid.toString())==true) {
  await  firestor.collection("Ivent").doc(idpost).update({"save":FieldValue.arrayRemove([uid])});
await  firestor.collection("Ivent").doc(idpost).collection("save").doc(uid).delete();
 await  firestor.collection("User").doc(uid).collection("save").doc(idpost).delete();
 
}else{
 await  firestor.collection("Ivent").doc(idpost).collection("save").doc(uid).set({
    "username": (userdocs.data()! as Map <String, dynamic>)["name"], 
    "uid": (userdocs.data()! as Map <String, dynamic>)["uid"], 
    "phone": (userdocs.data()! as Map <String, dynamic>)["phone"], 
    "photoProfil": (userdocs.data()! as Map <String, dynamic>)["photoProfil"], 
    "wilaya": (userdocs.data()! as Map <String, dynamic>)["wilaya"], 
    "conferm":false
  });
 
  
  await  firestor.collection("Ivent").doc(idpost).update({"save":FieldValue.arrayUnion([uid])});

   await  firestor.collection("User").doc(uid).collection("save").doc(idpost).set({
"datedubte":list["datedubte"],
"datefine":list["datefine"] ,
"distance":list["distance"] ,
  "images": list["images"],
  "nombresplaces": list["nombresplaces"],
  "save":list["save"],
    "participate":list["participate"],
  "price":list["price"] ,
    "destination":list["destination"] ,
    "username":list["username"] , 
    "uid":list["uid"]  ,
     "id":list["id"], 
    "details":list["details" ], 
    "urlImage":list["urlImage"] ,
     "photouser":list["photouser"],
      "time":list["time"] 
  } );
  await firestor.collection("User").doc(uid).collection("save").doc(idpost).update({"save":FieldValue.arrayUnion([uid])});
  
}

}
bool islodeinImage= false;

uploadImageindex(vale){
islodeinImage=vale;
update();
}
uploadImage( {
 required Imageurl,
required details, required nameproduct,required price  


} )async{
try {
  islodeinImage= true;
  update();
 var uid= firebaseAuth.currentUser!.uid;
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
 int len=    Random().nextInt(100000000);
 

  Store post=  Store( 
  price:price ,
    name: nameproduct,
    username: (userdocs.data()! as Map <String, dynamic>)["name"], uid: uid, id: "image $uid $len", details:details , urlimage: Imageurl, userphoto: (userdocs.data()! as Map <String, dynamic>)["photoProfil"], time: DateTime.now(),);

  await firestor.collection("Store").doc("image $uid $len").set(post.toJson()).then((value) =>  Get.back());
     
  
   islodeinImage= false;
  update();

} catch (e) {
    islodeinImage= false;
  update();
  Get.snackbar("error", e.toString());
}
  }



idetstor({idstor, name, details, price})async{
  await firestor.collection("Store").doc(idstor ).update({

    "name":name,
    "price":price,
    "details":details,
  }).then((value) =>  Get.back());

}







 
}