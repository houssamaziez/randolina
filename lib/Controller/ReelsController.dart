// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:randolina/Model/video.dart';
// import 'package:randolina/ct.dart';

// class ReelsController extends GetxController{
// final Rx<List<Video>> _videoList=Rx<List<Video>> ([]);
// var  videoList=[];


// @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     _videoList.bindStream(firestor.collection("Videos").snapshots().map((QuerySnapshot query) 
    
//     {
// List <Video> listval= [];
// var c;
// for (var i  in query.docs) {
//   listval.add(Video.fromSnap(i));
// videoList.add(query.docs);

//   print(i);
// }
//   print("--------------------------------"+videoList[0]["videoUrl"].toString());
// return listval;


//     }));
//   }

// }