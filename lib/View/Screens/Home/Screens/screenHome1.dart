
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/videocotroller.dart';
import 'package:randolina/View/Screens/Home/Screens/Postview/screenPost.dart';
import 'package:randolina/View/Screens/Home/Screens/VideoView/screenVideo.dart';
import 'package:randolina/ct.dart';




class ScreenReels extends StatefulWidget {
  const ScreenReels({Key? key}) : super(key: key);

  @override
  State<ScreenReels> createState() => _ScreenReelsState();
}

class _ScreenReelsState extends State<ScreenReels> {
   screenHomewidget(context) {
      var list = ["Home","Services", "Work", "About"];
  var colors = [Colors.orange, Colors.blue, Colors.red, Colors.green];
    // var controllervo= Get.put(ReelsController());

  PageController controller = PageController();

  
  return Scaffold(backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
         
       GetBuilder<VideoController>(
                            init: VideoController(),
                  builder: (controllers) {
           return controllers.isvscrenvideoddd==true?
                      StreamBuilder(
            stream: firestor.collection('Post').orderBy("time", descending: true).snapshots(),

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
                            child: PageView(
                            scrollDirection: Axis.vertical,
                            pageSnapping: true,
                            controller: controller,
                            children: List.generate(items.length, (index){
                              return
                                ScreenPost(
                          
                                  comentr:items[index]["comentr"].toString(),
                                  urlImage:items[index]["urlImage"],
                                  username:items[index]["username"],
                                  uid:firebaseAuth.currentUser!.uid,
                                  time:items[index]["time"],
                                  photouser:items[index]["photouser"],
                                  likes:items[index]["likes"],
                                  id:items[index]["id"],
                                  details:items[index]["details"] ,
                                );
                             
                            })
                            ),
                          );
                      
                       
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }










                       }
                      )
                    
                    : StreamBuilder(
            stream: firestor.collection('Videos').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return       
                 Expanded(
                child :PageView(
                        scrollDirection: Axis.vertical,
                        pageSnapping: true,
                        controller: controller,
                        children: List.generate(items.length, (index){
                          return 
                             scrvideo(items, index );
                        })
                      )
                 )   ;
           
                       
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }











 },
      );
        
        
       })
    ],
      ),
    );
    
    
}

   VideoreelsScreen scrvideo(List<QueryDocumentSnapshot<Object?>> items, int index) {
     return VideoreelsScreen(
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


