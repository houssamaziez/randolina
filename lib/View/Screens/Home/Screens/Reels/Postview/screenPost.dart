import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/controllerLiksComnt.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenAllMessage.dart';
import 'package:randolina/View/Screens/Home/widgetsHome/screenComent.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/profileUser.dart';

import '../../../../../../Controller/videocotroller.dart';
import '../../../../../../const.dart';
import '../../../../../Widgets/search.dart';
import '../menu.dart';
import '../screenHome1.dart';

class ScreenPost extends StatelessWidget {
  var cotrollervideo= Get.put(VideoController());

  _jamclick(){
if(likes.contains(uiddd.toString())==false){
  controllerlikcomnt.likePOST(idpost: id); 
    controllerlikcomnt.getlikelength(id);
  }
Get.defaultDialog(
   backgroundColor: Colors.transparent, title: ''
, content: Image.asset("images/likes.gif")

);
Timer(const Duration(seconds: 2), (){
  
Get.back();
});
  }

final time, details,data,isprofile, username , token, photouser, urlImage, likes, comentr , id;
final String uiddd, userid;

    ScreenPost({Key? key,required this.time,required this.details,required this.username,required this.photouser,required this.urlImage,required this.likes,required this.comentr,required this.uiddd,required this.id,required this.data, required this.userid,required this.isprofile,required this.token}) : super(key: key);
var controllerlikcomnt=Get.put(ControllerLikCont());
  @override
  Widget build(BuildContext context) {
    controllerlikcomnt.getlikelength(id);

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
        
                      isprofile==false?  Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(children: [
                        IconButton(onPressed: (){
                          Get.to(()=> ScreenSearch(docs: "User",tablename: "name",));
                        }, icon: Icon(Icons.search, size: 30,color: Colors.white,)),
                       const Spacer(),
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
                                                                controllerpageview.animateToPage(1, duration: Duration(milliseconds:300), curve: Curves.easeIn);


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
    controllerlikcomnt.likePOST(idpost:id);
    

                              }, icon:  Icon(Icons.favorite, size: 30,color:likes.contains(firebaseAuth.currentUser!.uid.toString())?Colors.red: Colors.white,)),
                              GetBuilder<ControllerLikCont>(init: ControllerLikCont(),
                                    builder: (contt) {
                                      return Text( contt.Listlikes.length==null?0.toString(): contt.Listlikes.length.toString(), style: TextStyle(color: Colors.white),);
                                     }
                                   ),
                                const SizedBox(height: 15,),
                                  IconButton(onPressed: (){
    
                                    Get.to(ScreenComent(id: id, doc: 'Post',));
                                  }, icon:Image.asset("images/CMNT.png")),
                                   Text( comentr.toString(), style: TextStyle(color: Colors.white),),
                                  Padding(
                               padding: const EdgeInsets.only(left: 10, bottom: 10),
                               child: minureels(userid, id, 'Post'),
                             )
                                ],
                              ),
                            ),
                          Positioned(
                            left: 10,
                            bottom: 100,child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(onTap: (){
                                  Get.to(SceenProflileAll( token: "",
                                    
                                     id:userid,imageprofile: photouser,name:  username ,));
                                },
                                  child: Row(
                                    children: [
                                       SizedBox(height: 50,width: 50,
             child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                  child: CachedNetworkImage(width: double.infinity,
                                                                          fit: BoxFit.cover,
                                                                          imageUrl:photouser.toString(),
                                                                          placeholder: (context, url) => spinkit,
                                                                          errorWidget: (context, url, error) =>
                                                                              const Icon(Icons.error),
                                                                        ),
                                ),
           ),
                                  SizedBox(width: 10,),
                                      
                                    Text(username, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      
                                    ],
                                  ),
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