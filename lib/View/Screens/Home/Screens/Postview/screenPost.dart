import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/controllerLiksComnt.dart';
import 'package:randolina/View/Screens/Home/Screens/Postview/screenComent.dart';

import '../../../../../Controller/videocotroller.dart';
import '../../../../../ct.dart';

class ScreenPost extends StatelessWidget {
  var cotrollervideo= Get.put(VideoController());

  _jamclick(){
if(likes.contains(uid.toString())==false){
  controllerlikcomnt.likePOST(idpost: id); }
Get.defaultDialog(
   backgroundColor: Colors.transparent, title: ''
, content: Image.asset("images/likes.gif")

);
Timer(const Duration(seconds: 2), (){
  
Get.back();
});
  }

final time, details, username , photouser, urlImage, likes, comentr,uid , id;

    ScreenPost({Key? key,required this.time,required this.details,required this.username,required this.photouser,required this.urlImage,required this.likes,required this.comentr,required this.uid,required this.id}) : super(key: key);
var controllerlikcomnt=Get.put(ControllerLikCont());
  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

    return 
    Scaffold(
      body: InkWell(onDoubleTap: _jamclick,
        child: Stack(
          children: [
            
             Container(height: heightphon(context),
             width: double.infinity,
               child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:urlImage,
                  placeholder: (context, url) => spinkit,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
             ),
          
           Container(
            height: heightphon(context),
             width: double.infinity,
            color: Colors.black.withOpacity(0.7),
          ),
            Center(
              child: Container(height:double.infinity ,
                 width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:urlImage,
                  placeholder: (context, url) => spinkit,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
        
                    Padding(
                          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: Row(children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.search, size: 30,color: Colors.white,)),
                            Spacer(),
                            Spacer(),
                            
                            InkWell(onTap: (){
                                cotrollervideo.chngescren();
      
                            },
                              child: Row(
                                children: [
                                            const  Padding(
                                    padding:  EdgeInsets.all(8.0),
                                    child: Text( "Images", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  Image.asset(  cotrollervideo.isvscrenvideoddd==true?"images/switch (3).png":"images/switch (2).png"),
                             const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Text(  "Videos" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              )  ],
                              ),
                            ),
                            Spacer(),
                            IconButton(onPressed: (){}, icon:Image.asset("images/bubble-chat.png")),
                            ],),
                        ),
 
                            Positioned(right: 10,
                            bottom: size.height*0.17,
                              child: Column(
                                children: [
                                  IconButton(onPressed: (){
    
    controllerlikcomnt.likePOST(idpost: id);
    
                                  }, icon:  Icon(Icons.favorite, size: 30,color:likes.contains(uid)?Colors.red: Colors.white,)),
                                   Text(  likes.length.toString(), style: TextStyle(color: Colors.white),),
                                const SizedBox(height: 15,),
                                  IconButton(onPressed: (){
    
                                    Get.to(ScreenComent(id: id, doc: 'Post',));
                                  }, icon:Image.asset("images/CMNT.png")),
                                   Text( comentr.toString(), style: TextStyle(color: Colors.white),),
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
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                    backgroundImage: NetworkImage(photouser),radius: 24,),
                                SizedBox(width: 10,),
      
                                  Text(username, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      
                                  ],
                                ),
                             const   SizedBox(height: 10,),
                                  Container(
                                    width: size.width*0.7,
                                    child: Text(details, style: TextStyle(color: Colors.white70),)),
      
                              ],
                            ))
          
          
          
          ],
        ),
      ),
    )
  ;
  }
}