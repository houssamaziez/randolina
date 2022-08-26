// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/videocotroller.dart';
import 'package:randolina/View/Widgets/search.dart';
import 'package:randolina/const.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../Controller/controllerLiksComnt.dart';
import '../../Profile/profileClien/profileUser.dart';
import '../../../widgetsHome/screenComent.dart';
import '../../messages/screenAllMessage.dart';

class VideoreelsScreen extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  final UrlVideo, thumbnial,isprofile,likes,id, comentr, caption, username, profilephoto ,uidUser;
  final bool _isloading=false;
    const VideoreelsScreen({Key? key,required this.UrlVideo,required this.thumbnial,required this.likes,required this.comentr,required this.caption,required this.username,required this.profilephoto,required this.id,required this.uidUser,required this.isprofile}) : super(key: key);

  @override
  State<VideoreelsScreen> createState() => _VideoreelsScreenState();
}

class _VideoreelsScreenState extends State<VideoreelsScreen> {
var controllerlikcomnt=Get.put(ControllerLikCont());
var _uid= firebaseAuth.currentUser!.uid;
  var cotrollervideo= Get.put(VideoController());
      late VideoPlayerController controller ;
@override
  void initState() {
 print( widget. _isloading);
  controller  = VideoPlayerController.network(
        widget.UrlVideo,  )
      ..initialize().then((  con) {
setState(() {
    controller.play();
});
      });
    controller.play();

setState(() {
    controller.play();
    controller.setVolume(1);
    // controller.setLooping(true);  
}); 
    super.initState();
}
    PageReels(context,  {url}) {
    // var controllervo= Get.put(ReelsController());
    return InkWell(onTap: (){},
      child: screenVideo(context,controller),
    );
  }
  @override
  void dispose() {
        controller.pause();
        controller.dispose();

    super.dispose();
    
  }
   _jamclick(){
if(widget.likes.contains(_uid.toString())==false){
  controllerlikcomnt.likeVideo(idpost:widget. id); }
Get.defaultDialog(
   backgroundColor: Colors.transparent, title: ''
, content: Image.asset("images/likes.gif")

);
Timer(const Duration(seconds: 2), (){
Get.back();
});
  }
  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
   return Scaffold(
    backgroundColor: Colors.black,
    body: Stack(children: [
      Container(
        width: double.infinity,
        height: size.height,
        
        child:CachedNetworkImage(width: double.infinity,
                                                                fit: BoxFit.cover,
                                                                imageUrl:widget.thumbnial.toString(),
                                                                placeholder: (context, url) => spinkit,
                                                                errorWidget: (context, url, error) =>
                                                                    const Icon(Icons.error),
                                                              ),
        
        
      ),
   PageReels(context, url: widget.UrlVideo),
              
         widget.     isprofile==false?  Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(children: [
                        IconButton(onPressed: (){
                          Get.to(()=>   ScreenSearch(docs: "User",tablename: "name",));
                        }, icon: Icon(Icons.search, size: 30,color: Colors.white,)),
                       const Spacer(),
                        Spacer(),
                        InkWell(onTap: (){
                            cotrollervideo.chngescren();
                        },
                          child: GetBuilder<VideoController>(init:VideoController() ,
                            builder: (cont) {
                              return Row(
                                children: [
                                          const  Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Text( "Images", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              )  ,
                                  Image.asset(  cont.isvscrenvideoddd== true?"images/switch (3).png":"images/switch (2).png"),
                            const  Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Text( "Videos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              )  ,],
                              );
                            }
                          ),
                        ),
                        Spacer(),

                        
                        
                        IconButton(onPressed: (){
                                      Get.to(ScreenAllMessage());
                          
                        }, icon:Image.asset("images/bubble-chat.png")),

                        ],),
                    ):Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(children: [
                        IconButton(onPressed: (){
                        Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back, size: 30,color: Colors.white,)),
                       const Spacer(),
                        ],),
                    ) ,
                        Positioned(right: 10,
                        bottom: size.height*0.17,
                          child: Column(
                            children: [
                              IconButton(onPressed: (){
    controllerlikcomnt.likeVideo(idpost:widget. id);

                              }, icon:  Icon(Icons.favorite, size: 30,color:widget.likes.contains(_uid.toString())?Colors.red: Colors.white,)),
                               Text( widget. likes.length.toString(), style: TextStyle(color: Colors.white),),
                            const SizedBox(height: 15,),
                              IconButton(onPressed: (){
                                    Get.to(ScreenComent(id:widget. id, doc: "Videos",));

                              }, icon:Image.asset("images/CMNT.png")),
                               Text(widget. comentr.toString(), style: TextStyle(color: Colors.white),),
                            const SizedBox(height: 10,),
                              IconButton(onPressed: (){
                                
                              }, icon:Image.asset("images/Vector35 (1).png")),
                            ],
                          ),
                        ),
                      Positioned(
                        left: 10,
                        bottom: 100,child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                           InkWell(onTap: (){
                                           Get.to(SceenProflileAll(data: {}, id: widget.uidUser,imageprofile:widget.profilephoto ,name:  widget.username ));
 },
            child:Row(
                      children: [  SizedBox(height: 50,width: 50,
             child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                  child: CachedNetworkImage(width: double.infinity,
                                                                          fit: BoxFit.cover,
                                                                          imageUrl:widget.profilephoto.toString(),
                                                                          placeholder: (context, url) => spinkit,
                                                                          errorWidget: (context, url, error) =>
                                                                              const Icon(Icons.error),
                                                                        ),
                                ),
           ),
                               SizedBox(width: 10,),
                            
                                Text(widget.username, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            
                                ],
                              ),
                            ),
                         const   SizedBox(height: 10,),
                              Container(
                                width: size.width*0.7,
                                child: Text(widget.caption, style: TextStyle(color: Colors.white70),)),

                          ],
                        ))
   
   ],) ,);
  }
     screenVideo(context,VideoPlayerController controller) {
      return InkWell(
        
onDoubleTap: _jamclick,
        onTap: (){ 

          // If the video is playing, pause it.
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        // If the video is paused, play it.
        controller.play();
      }
      },
        child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child:VideoPlayer(controller),
                  ),
      );
    }
 
}
  

