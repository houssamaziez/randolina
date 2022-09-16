
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/videocotroller.dart';
import 'package:randolina/View/Screens/Home/Screens/Reels/Postview/screenPost.dart';
import 'package:randolina/View/Screens/Home/Screens/Reels/VideoView/screenVideo.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenAllMessage.dart';
import 'package:randolina/const.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';

class ScreenReelsInProfile extends StatefulWidget {
  final Stream , positionvideo, isvideo;
  const ScreenReelsInProfile({Key? key,required this.Stream,required this.positionvideo,required this.isvideo}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<ScreenReelsInProfile> createState() => _ScreenReelsInProfileState(positionvideo);
}

class _ScreenReelsInProfileState extends State<ScreenReelsInProfile> {
  final index;

  _ScreenReelsInProfileState(this.index);
  
   screenHomewidget(context, controllerpageview2) {
    // var controllervo= Get.put(ReelsController());
 
  PageController controller = PageController();

  return Scaffold(backgroundColor: Colors.black,
      body:reels(context,controllerpageview2) ,
    );
    
    
}

   RefreshIndicator reels(BuildContext context, controllerpageview2) {
     return RefreshIndicator(onRefresh: ()async{
             return Future.delayed(Duration(seconds: 1), (){
setState(() {
              });
             });
             },
               child:  SizedBox(height: heightphon(context)+20,
          width: widthphon(context),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
             GetBuilder<VideoController>(
           init: VideoController(),
                        builder: (controllers) {
                 return  
                       listreels(stream: widget.Stream,
                         count: "video"  ,controllerpageview2: controllerpageview2);
                    
              
             })
            ],
            ),
          ),
        );
   }

   StreamBuilder<QuerySnapshot<Map<String, dynamic>>> listreels({required stream, count, controllerpageview2}) {
    int position =0;
     return StreamBuilder( 
            stream: stream.snapshots(),

                        builder:  (context, AsyncSnapshot<QuerySnapshot> snapshot){
              var items = snapshot.data?.docs ?? [];

if (snapshot.connectionState == ConnectionState.waiting) {
        return     Padding(
          padding:   EdgeInsets.only(top: heightphon(context, size: 0.4) ,),
          child: spinkit,
        );
      } else if (snapshot.connectionState == ConnectionState.active
          || snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return        Expanded(
            child: PageView.builder(
              controller: controllerpageview2,
              key: const PageStorageKey<String>("pageTwo"),

                 scrollDirection: Axis.vertical, 
onPageChanged: (int positione) {
  
              position=positione;
          },
              itemCount: items.length,
              itemBuilder: 
             (context,index) {
                return Container(height: heightphon(context),
                width:widthphon(context),
                  child:count=="video"?scrvideo(items, index , position): photosreels(items, index),
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
     return ScreenPost(token:items[index]["token"] ,
      userid: items[index]["uid"],
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

     scrvideo(List<QueryDocumentSnapshot<Object?>> items, int index, position) {
     return widget. isvideo==true? VideoreelsScreen(isprofile: true,
      uidUser: items[index]["uid"],numvidoe: position,token:"" ,
                  id:items[index]["id"] ,
                  UrlVideo: items[index]["videoUrl"]!,
                  caption:  items[index]["caption"],
                  comentr: items[index]["comentr"],
                  likes: items[index]["likes"],
                  profilephoto: items[index]["profilephoto"],
                  thumbnial: items[index]["thumbnial"] ,
                  username:  items[index]["username"] ,
                  )
                  :
                 ScreenPost(token: items[index]["token"],
                  userid: items[index]["uid"],
                                data: {
                                },isprofile: true,
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
  var controllerMessanger= Get.put(ControllerMessanger());
@override
  void initState() {

    super.initState();
  }

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
PageController controllerpageview2=PageController(initialPage:index);

    return screenHomewidget(context, controllerpageview2);
  }
}


