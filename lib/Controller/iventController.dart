// ignore: file_names
// ignore_for_file: file_names

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../Model/event.dart';
import '../View/Screens/Home/Screens/Events/addIvent.dart';
import '../ct.dart';

class IventsController extends  GetxController{
late Rx<File?> _pickedImage;

File? get profilePhoto =>  _pickedImage.value;

getdatativent({required idpost})async{
 DocumentSnapshot userdocs=await firestor.collection("Ivent").doc(idpost).get();
 return (userdocs.data()! as Map <String, dynamic>) ['confermnum'].length;

}

participer( {idpost,required list})async{
  var uid= firebaseAuth.currentUser!.uid;
  DocumentSnapshot<Map<String, dynamic>> _post=await  firestor.collection("Ivent").doc(idpost).get();
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();

if ((_post.data()!)["participate"].contains(uid)) {
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


_uploadImageToStorge(id ,imagepath)async{

 var ref= firebaseStorage.ref().child("ImagePost").child(id);
 TaskSnapshot uploadtask=await ref.putFile( imagepath, );
 TaskSnapshot snp=await uploadtask;
 var downloadUrl=snp.ref.getDownloadURL();
 
  return downloadUrl;
}

bool islodeinImage= false;


uploadImage( {
  
   required  imagepath,required 
details, required destination,required price  ,required distance,required nombresplaces,required datedubte,required datefine


} )async{
try {
  islodeinImage= true;
  update();
 var uid= firebaseAuth.currentUser!.uid;
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
 int len=    Random().nextInt(100000000);
 
  var Imageurl=await    _uploadImageToStorge("image $uid $len", imagepath);

  Ivent post=  Ivent(datedubte:datedubte,datefine:datefine ,distance: distance,
  images: [],
  nombresplaces: nombresplaces,
  participate:[],
  price:price ,
    destination: destination,
    username: (userdocs.data()! as Map <String, dynamic>)["name"], uid: uid, id: "image $uid $len", details:details , urlImage: Imageurl, photouser: (userdocs.data()! as Map <String, dynamic>)["photoProfil"], time: DateTime.now());

  await firestor.collection("Ivent").doc("image $uid $len").set(post.tojeson()).then((value) =>  Get.back());
   islodeinImage= false;
  update();
} catch (e) {
    islodeinImage= false;
  update();
  Get.snackbar("error", e.toString());
}
  }












  
var edittext;
editivent( {
 required idivnt,
  required 
details, required destination, required price, required distance,required nombresplaces,


} )async{

try {
  edittext= true;
  update();
//  var uid= firebaseAuth.currentUser!.uid;
//  DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
//  int len=    Random().nextInt(100000000);
 
//   var Imageurl=await    _uploadImageToStorge("image $uid $len", imagepath);

  await firestor.collection("Ivent").doc(idivnt ).update(
    {
"price":price,
"distance":distance,
"nombresplaces":nombresplaces,
"destination":destination,
"details":details,
    }
  ).then((value) {
    Get.back();
    Get.back();
  });
   edittext= false;
  update();
} catch (e) {
    edittext= false;
  update();
  Get.snackbar("error", e.toString());
}
  }


var editdate;
   

editiventdate( {
 required idivnt,
  required 
details, required destination, required price, datedubteivent  ,required distance,required nombresplaces,required datedubte,required datefine


} )async{

try {
  editdate= true;
  update();
//  var uid= firebaseAuth.currentUser!.uid;
//  DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
//  int len=    Random().nextInt(100000000);
 
//   var Imageurl=await    _uploadImageToStorge("image $uid $len", imagepath);

  await firestor.collection("Ivent").doc(idivnt ).update(
    {
"datedubte":datedubte,
"datefine":datefine,
"time":datedubteivent,
    }
  ).then((value) {
    Get.back();
    Get.back();
  });
   editdate= false;
  update();
} catch (e) {
    editdate= false;
  update();
  Get.snackbar("error", e.toString());
}
  }




confermpart(uid, idpost)async{

try {
  await  firestor.collection("Ivent").doc(idpost).collection("participate").doc(uid).update({

"conferm":true
  }).then((value) => Get.snackbar("conferm", "done"));
  await  firestor.collection("Ivent").doc(idpost).update({"confermnum":FieldValue.arrayUnion([uid])});

}


 catch (e) {
  
}
}
deletpart(uid, idpost)async{

try {
  await  firestor.collection("Ivent").doc(idpost).collection("participate").doc(uid).update({

"conferm":false
  }).then((value) => Get.snackbar("conferm", "delete"));
  await  firestor.collection("Ivent").doc(idpost).update({"confermnum":FieldValue.arrayRemove([uid])});

} catch (e) {
  
}
}

}