// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/videocotroller.dart';
import 'package:randolina/View/Screens/Home/Screens/Reels/menu.dart';
import 'package:randolina/View/Widgets/search.dart';
import 'package:randolina/const.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../Controller/controllerLiksComnt.dart';
import '../../Profile/profileClien/profileUser.dart';
import '../../../widgetsHome/screenComent.dart';
import '../../messages/screenAllMessage.dart';
import '../Postview/widgetS/appbarvide.dart';

class VideoreelsScreen extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  final UrlVideo, thumbnial,isprofile,likes,id, comentr, caption, username, profilephoto ,uidUser;
  final bool _isloading=false ;
  final int numvidoe;
    const VideoreelsScreen({Key? key,required this.UrlVideo,required this.thumbnial,required this.likes,required this.comentr,required this.caption,required this.username,required this.profilephoto,required this.id,required this.uidUser,required this.isprofile, required this.numvidoe}) : super(key: key);

  @override
  State<VideoreelsScreen> createState() => _VideoreelsScreenState();
}

class _VideoreelsScreenState extends State<VideoreelsScreen> {
var controllerlikcomnt=Get.put(ControllerLikCont());
var _uid= firebaseAuth.currentUser!.uid;
  var cotrollervideo= Get.put(VideoController());//player controller
  VideoPlayerController? controller;

  @override
  void initState() {
    initializePlayer(widget.UrlVideo);

    super.initState();
    //initialize player 
  }

//Initialize Video Player
  void initializePlayer(String url) async {
  try {
      final fileInfo = await checkCacheFor(url);
    if (fileInfo == null) {
      controller = VideoPlayerController.network(url);
      controller!.initialize().then((value) {
        cachedForUrl(url);
        setState(() {
            widget. numvidoe==0?controller!.pause():
          controller!.play();
       controller!.setLooping(true);
        });
      });
    } else {
      final file = fileInfo.file;
      controller = VideoPlayerController.file(file);
      controller!.initialize().then((value) {
        setState(() {
        controller!.play();
       controller!.setLooping(true);
        });
      });
    }
  } catch (e) {
    
  }
  }
//: check for cache
  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

//:cached Url Data
  void cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      print('downloaded successfully done for $url');
    });
  }
//:Dispose
  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    super.dispose();
  }
  des()async{
     await   controller!.dispose();
  }
   _jamclick(){
if(widget.likes.contains(_uid.toString())==false){

  controllerlikcomnt.likeVideo(idpost:widget. id); }
  
  Get.dialog(Image.asset("images/likes.gif"));
 
Timer(const Duration(milliseconds: 1500), (){
Get.back();
});

  }
  PageReels(context,  {url}) {
    // var controllervo= Get.put(ReelsController());
    return InkWell(onTap: (){},
      child: screenVideo(context,controller),
    );
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
                        InkWell(onTap: (){
                         controller!.dispose();
                            cotrollervideo.chngescren();
                        },
                          child: appbarvideo(),
                        ),
                       const Spacer(),
                        IconButton(onPressed: (){
                           Get.to(()=> const ScreenAllMessage());
                        }, icon:
                            Image.asset("images/bubble-chat.png"),
                      ),
                        ],),
                    ):Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(children: [
                        IconButton(onPressed: (){
                        Navigator.pop(context);
                        }, icon:const Icon(Icons.arrow_back, size: 30,color: Colors.white,)),
                       const Spacer(),
                        ],),
                    ) ,
                        Positioned(right: 10,
                        bottom: size.height*0.17,
                          child: Column(
                            children: [
                              IconButton(onPressed: (){
    controllerlikcomnt.likeVideo(idpost:widget. id);

                              }, icon:  Icon(Icons.favorite, size: 30,color:widget.likes.contains(_uid.toString())?
                              Colors.red: Colors.white,)),
                               Text( widget. likes.length.toString(), style: TextStyle(color: Colors.white),),
                            const SizedBox(height: 15,),
                              IconButton(onPressed: (){
                                    Get.to(ScreenComent(id:widget. id, doc: "Videos",));

                              }, icon:Image.asset("images/CMNT.png", 
            height: 30)),
                               Text(widget. comentr.toString(), style: TextStyle(color: Colors.white),),
                           
                             Padding(
                               padding: const EdgeInsets.only(left: 10, bottom: 10),
                               child: minureels(widget.uidUser, widget.id, 'Videos'),
                             )
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
        controller!.dispose();

                                           Get.to(SceenProflileAll( id: widget.uidUser,imageprofile:widget.profilephoto ,name:  widget.username,  ));
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

  screenVideo(context, controller) {
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
                    child:(controller == null)
        ? const Text('wait..')
        : ((controller.value.isInitialized)
            ? VideoPlayer(controller, )
            : const Text('Loading...')),
                  ),
      );
    }
}