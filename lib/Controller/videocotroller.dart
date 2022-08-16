import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:randolina/Model/video.dart';
import 'package:randolina/ct.dart';
import 'package:video_compress/video_compress.dart';

class VideoController extends GetxController {
 bool  islodeinvideo=false;
_getThumnail(videoPath)async{

  final thumbnails= await VideoCompress.getFileThumbnail(videoPath);
  return thumbnails;
}
_uploadImagetostorage(id, videoPath)async{
 var ref= firebaseStorage.ref().child("thumbnails").child(id);
 var uploadtask= ref.putFile(await _getThumnail(videoPath));
 TaskSnapshot snp=await uploadtask;
 var downloadUrl=snp.ref.getDownloadURL();
 return downloadUrl;
}


  _comprassvideo(videopath)async{
    
    var compressvideo=  await VideoCompress.compressVideo(videopath, );

    return File(videopath);
  }



_uploadVideoToStorge(id ,videopath)async{

 var ref= firebaseStorage.ref().child("videos").child(id);
 TaskSnapshot uploadtask=await ref.putFile(await _comprassvideo(videopath), );
 TaskSnapshot snp=await uploadtask;
 var downloadUrl=snp.ref.getDownloadURL();
 
  return downloadUrl;
}
  // upload video
  uploadvideo( {required  detialsvideo,required  videopath,} )async{
try {
  islodeinvideo= true;
  update();
 var uid= firebaseAuth.currentUser!.uid;
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
 var aldocs= await firestor.collection("thumbnails").get();
 int len=    Random().nextInt(100000000);
 
  var videourl=await    _uploadVideoToStorge("video $uid $len", videopath);
  var thumbnail=await _uploadImagetostorage('video $uid $len', videopath);

  Video video=  Video(
    
    username: (userdocs.data()! as Map <String, dynamic>)["name"], uid: uid, id: 'video $uid $len', likes: [], caption:detialsvideo , videoUrl: videourl, thumbnial: thumbnail, profilephoto: (userdocs.data()! as Map <String, dynamic>)["photoProfil"], comentr: 0, shereCount: 0);

  await firestor.collection("Videos").doc('video $uid $len').set(video.tojeson());

   islodeinvideo= false;
  update();
  Get.back();
} catch (e) {
    islodeinvideo= false;
  update();
  Get.snackbar("error", e.toString());
}
  }


 var  isvscrenvideoddd= true;

 chngescren(){
  if (isvscrenvideoddd==true) {
  isvscrenvideoddd = false;
  update();
} else  {
  isvscrenvideoddd = true;
  update();


}  
 }
}