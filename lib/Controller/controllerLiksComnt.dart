// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Model/comment.dart';
import 'package:randolina/const.dart';

class ControllerLikCont extends  GetxController{


likePOST( {idpost,})async{
  var uid= firebaseAuth.currentUser!.uid;
  DocumentSnapshot<Map<String, dynamic>> post=await  firestor.collection("Post").doc(idpost).get();

if ((post.data()!)["likes"].contains(uid)) {
  await  firestor.collection("Post").doc(idpost).update({"likes":FieldValue.arrayRemove([uid])});
}else{

  await  firestor.collection("Post").doc(idpost).update({"likes":FieldValue.arrayUnion([uid])});

}

}

likeVideo( {idpost,})async{
  var uid= firebaseAuth.currentUser!.uid;
  DocumentSnapshot<Map<String, dynamic>> post=await  firestor.collection("Videos").doc(idpost).get();

if ((post.data()!)["likes"].contains(uid)) {
  await  firestor.collection("Videos").doc(idpost).update({"likes":FieldValue.arrayRemove([uid])});
}else{

  await  firestor.collection("Videos").doc(idpost).update({"likes":FieldValue.arrayUnion([uid])});

}

}









postComment({required idpost ,required String textcomment,required docs})async{
  var userid=  firebaseAuth.currentUser!.uid;
  var user=await firestor.collection('User').doc(userid).get();
if (textcomment.isNotEmpty) {
  var alldocs=await firestor.collection(docs).doc(idpost).collection("comment").get();
   Comment comment=Comment(time: DateTime.now(), username: (user.data() as Map  <String, dynamic>)["name"], comment: textcomment, id: 'coment ${alldocs.docs.length}', uid: userid, profilephoto:  (user.data() as Map  <String, dynamic>)["photoProfil"], likes: []);
    await firestor.collection(docs).doc(idpost).collection("comment").doc('coment ${alldocs.docs.length}').set(comment.tojeson());
    await firestor.collection(docs).doc(idpost) .update({"comentr": alldocs.docs.length+1});
}
}



settingcmnet({required id ,required idpost}){
  
  Get.defaultDialog(title: "Delete", 

  content: const Text('Do you want to delete your comment'),
  cancel:TextButton(onPressed: ()async{
Get.back();

  }, child: const Text("Cancel")) ,
  confirm: TextButton(onPressed: ()async{

  await firestor.collection('Post').doc(idpost).collection("comment").doc(id).delete().then((value) => Get.back());

  }, child: const Text("Confirm")));

}








List Listlikes = [];
getlikelength(id) async {
   DocumentSnapshot<Map<String, dynamic>> myVideos = await firestor
        .collection('Post').doc(id)
        .get();
  Listlikes=await myVideos.data()!["likes"];
  update();
}
 var Listlikesvideo;


getlikelengthVideo(id) async {
   DocumentSnapshot<Map<String, dynamic>> myVideos = await firestor
        .collection('Videos').doc(id)
        .get();
  Listlikesvideo=myVideos.data()!["likes"];
  update();
}

}