
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/videocotroller.dart';
import 'package:randolina/View/Screens/Home/Screens/Reels/Postview/screenPost.dart';
import 'package:randolina/View/Screens/Home/Screens/Reels/VideoView/screenVideo.dart';
import 'package:randolina/const.dart';

class ScreenReels extends StatefulWidget {
  const ScreenReels({Key? key}) : super(key: key);
  @override
  State<ScreenReels> createState() => _ScreenReelsState();
}

class _ScreenReelsState extends State<ScreenReels> {
   screenHomewidget(context) {
    // var controllervo= Get.put(ReelsController());

  PageController controller = PageController();
  return Scaffold(backgroundColor: Colors.black,
      body: Container(height: heightphon(context)+20,
      width: widthphon(context),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
         GetBuilder<VideoController>(
   init: VideoController(),
                    builder: (controllers) {
             return controllers.isvscrenvideoddd==true?
                        listreels(stream: firestor.collection('Post').orderBy("time", descending: true,  ),
                     count: "photos"  ):listreels(stream: firestor.collection('Videos'),
                     count: "video"  );
                
          
         })
    ],
        ),
      ),
    );
    
    
}

   StreamBuilder<QuerySnapshot<Map<String, dynamic>>> listreels({required stream, count}) {
     return StreamBuilder(
            stream: stream.snapshots(),

                        builder:  (context, AsyncSnapshot<QuerySnapshot> snapshot){
              var items = snapshot.data?.docs ?? [];

if (snapshot.connectionState == ConnectionState.waiting) {
        return     Padding(
          padding:   EdgeInsets.only(top: heightphon(context, size: 0.4)),
          child: spinkit,
        );
      } else if (snapshot.connectionState == ConnectionState.active
          || snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return        Expanded(
            child: PageView.builder(
                 scrollDirection: Axis.vertical,
onPageChanged: (int position) {
            print('page changed. current: $position');
          },
              itemCount: items.length,
              itemBuilder: 
             (context,index) {
                return Container(height: heightphon(context),
                width:widthphon(context),
                  child:count=="video"?scrvideo(items, index ): photosreels(items, index),
                );
              }
            ),
          );
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }

                       }
                      );
   }

   ScreenPost photosreels(List<QueryDocumentSnapshot<Object?>> items, int index) {
     return ScreenPost(userid: items[index]["uid"],
                                data: {
                                  
                                },isprofile: false,
                                        comentr:items[index]["comentr"].toString(),
                                        urlImage:items[index]["urlImage"],
                                        username:items[index]["username"],
                                        uiddd:firebaseAuth.currentUser!.uid,
                                        time:items[index]["time"],
                                        photouser:items[index]["photouser"],
                                        likes:items[index]["likes"],
                                        id:items[index]["id"],
                                        details:items[index]["details"] ,
                                      );
   }

   VideoreelsScreen scrvideo(List<QueryDocumentSnapshot<Object?>> items, int index) {
     return VideoreelsScreen(isprofile: false,
      uidUser: items[index]["uid"],
                  id:items[index]["id"] ,
                  UrlVideo: items[index]["videoUrl"],
                  caption:  items[index]["caption"],
                  comentr: items[index]["comentr"],
                  likes: items[index]["likes"],
                  profilephoto: items[index]["profilephoto"],
                  thumbnial: items[index]["thumbnial"] ,
                  username:  items[index]["username"] ,
                  );
   }

 
  @override
  Widget build(BuildContext context) {
    return screenHomewidget(context);
  }
}


