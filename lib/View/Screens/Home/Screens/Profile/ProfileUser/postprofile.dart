import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Controller/ProfileController.dart';
import '../../../../../../const.dart';
import '../../Reels/Postview/screenPost.dart';
import '../../Reels/VideoView/screenVideo.dart';

ListView postprofile(BuildContext context, String uid, controllecr,postnumber) {
    return ListView(
              children: [
                SizedBox(height: heightphon(context,size: 0.35)),
   Container(
                decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), 
                topRight: Radius.circular(20),

)
                ),
             
                
                child: Column(children: [
                  const SizedBox(height: 15,),
                
                  Container(width: 100,
                     height:0.5,color: Colors.grey,
                  ),
const SizedBox(height: 15,),
                   SizedBox(height: 60,
                     child: Row(children:[
                           Expanded(
                            child:InkWell(
                               onTap: (){
                                controllecr.indextchange(0);
                              },
                              child: GetBuilder<ProfileController>(
                                      init: ProfileController(),
                                      builder: (contt) {
                                       return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                            
                                          children: [
                                            Image.asset(contt.idext==0?'images/photoact.png':'images/photodesctv.png', height: 30,),
                                         SizedBox(width: 10,),   Text("Photos"),
                                          ],
                                        );}
                                    ),
                            ),
                           ),
                             const   Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: const VerticalDivider(color: Colors.grey, width: 0.5),
                                ),

                          Expanded(
                            child:  InkWell(
                              onTap: (){
                                controllecr.indextchange(1);
                              },
                              child:GetBuilder<ProfileController>(
                                      init: ProfileController(),
                                      builder: (contt) {
                                        return Row(crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(contt.idext==1?'images/videoact.png':'images/videodesct.png', height: 30,),
                                         SizedBox(width: 10,),   Text("Videos"),
                                          ],
                                        );
                                     }
                                    ),
                            ),
                          ),
                         
                          // Padding(
                          //   padding:  const EdgeInsets.all(7.0),
                          //   child: Text("124 following", style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),),
                          // ),

         ],),
                   ),
// POST profile 
GetBuilder<ProfileController>(
                                      init: ProfileController(),
                                      builder: (contt) {
                                        return   contt.idext==0?
                                        
                                        
  StreamBuilder(
          stream: firestor.collection('Post').where("uid", isEqualTo: uid).orderBy("time", descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var items = snapshot.data?.docs ?? [];

 if (snapshot.connectionState == ConnectionState.waiting) {
      return   const Padding(
        padding: const EdgeInsets.all(100.0),
        child: spinkit,
      );
    } else if (snapshot.connectionState == ConnectionState.active
        || snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        return 
              GridView.count(
                   physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,

crossAxisCount: 3,
children: List.generate(items.length, (index) {
postnumber =items.length;

  return Padding(
        padding: const  EdgeInsets.all(2.0),
        child: InkWell(onTap: (){

          Get.to(
            
            ScreenPost(
              isprofile: true,userid: items[index]["uid"],
            data: items[index] ,
            time: items[index]["time"], details: items[index]["details"], username: items[index]["username"], photouser: items[index]["photouser"], urlImage:  items[index]["urlImage"], likes: items[index]["likes"], comentr: items[index]["comentr"], uiddd:items[index]["uid"], id: items[index]["id"]));
        },
          child: Card(color: Colors.blue.shade200,
            child:CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:items[index]["urlImage"],
                  placeholder: (context, url) => spinkit,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
          ),
        ),
  );
}),
);
                  
      } else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }





 }
             )
             :// Vidoe profile 
            StreamBuilder(
          stream: firestor.collection('Videos').where("uid", isEqualTo:firebaseAuth.currentUser!.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var items = snapshot.data?.docs ?? [];
 if (snapshot.connectionState == ConnectionState.waiting) {
      return   const Padding(
        padding:  EdgeInsets.all(100.0),
        child: spinkit,
      );
    } else if (snapshot.connectionState == ConnectionState.active
        || snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        return 
              GridView.count(
                   physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,

crossAxisCount: 3,
children: List.generate(items.length, (index) {
postnumber =items.length;

  return Padding(
        padding: const  EdgeInsets.all(2.0),
        child: InkWell(onTap: (){
          Get.to( VideoreelsScreen(isprofile:true ,numvidoe: 2,
    uidUser: items[index]["uid"],
                id:items[index]["id"] ,
                UrlVideo: items[index]["videoUrl"],
                caption:  items[index]["caption"],
                comentr: items[index]["comentr"],
                likes: items[index]["likes"],
                profilephoto: items[index]["profilephoto"],
                thumbnial: items[index]["thumbnial"] ,
                username:  items[index]["username"] ,
                ));
        },
          child: Card(color: Colors.blue.shade200,
            child:Stack(
              children: [
                CachedNetworkImage(width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl:items[index]["thumbnial"],
                      placeholder: (context, url) => spinkit,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Center(child: Image.asset(
                'images/play-button.png',
                filterQuality: FilterQuality.high,
                height: 50,
                ))
              ],
            ),
          ),
        ),
  );
}),
);
                  
      } else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }





 }
             ) ;





}
),
            


               SizedBox(height: heightphon(context,size: 0.72)),
 ],),
                )
              ],
            );
  }
