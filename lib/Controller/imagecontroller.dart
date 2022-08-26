// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore, non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:randolina/Model/post.dart';
import 'package:randolina/View/Screens/Home/ConfermScreens/confermImage.dart';

import '../const.dart';

class ImageController extends  GetxController{
late Rx<File?> _pickedImage;

File? get profilePhoto =>  _pickedImage.value;
// ignore: prefer_typing_uninitialized_variables
var image;
var imagefile;
//  Get image picker
pickImage() async{



  //  get image
final imagePicker=await ImagePicker().pickImage(source: ImageSource .gallery);
if (imagePicker!=null) {
  Get.snackbar("Profile Picture", "You have successfully selected your profile picture");
  _pickedImage =Rx<File?>(File(imagePicker.path));


CroppedFile? croppedFile = await ImageCropper().cropImage(

      sourcePath: imagePicker.path,maxHeight: 1000,
      aspectRatio:const CropAspectRatio(ratioX:9 , ratioY: 16) ,
     
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: color1,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      
       
      ],
    );
imagefile=File(croppedFile!.path);
 image=croppedFile.path;
 update();
 Get.to(const ConfrImage());
}
}


_uploadImageToStorge(id ,imagepath)async{

 var ref= firebaseStorage.ref().child("ImagePost").child(id);
 TaskSnapshot uploadtask=await ref.putFile( imagepath, );
 TaskSnapshot snp=uploadtask;
 var downloadUrl=snp.ref.getDownloadURL();
 
  return downloadUrl;
}

bool islodeinImage= false;
 index(vale){
islodeinImage=vale;
update();
}

uploadImage( { required  imagepath,required detailspost,required Imageurl} )async{
try {
  islodeinImage= true;
  update();
 var uid= firebaseAuth.currentUser!.uid;
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
 int len=    Random().nextInt(100000000);
 

  Post post=  Post(username: (userdocs.data()! as Map <String, dynamic>)["name"], uid: uid, id: "image $uid $len", likes: [], details:detailspost , urlImage: Imageurl, comentr: 0, photouser: (userdocs.data()! as Map <String, dynamic>)["photoProfil"], time: DateTime.now());

  await firestor.collection("Post").doc("image $uid $len").set(post.tojeson()).then((value) =>  Get.back());
   islodeinImage= false;
  update();
} catch (e) {
    islodeinImage= false;
  update();
  Get.snackbar("error", e.toString());
}
  }



}