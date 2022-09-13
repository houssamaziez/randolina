 import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/iventcard_in_profileclien.dart';

import '../../../../../../Controller/ProfileController.dart';
import '../../../../../../const.dart';
import '../../Reels/Postview/screenPost.dart';
import '../../Reels/VideoView/screenVideo.dart';
import '../ProfileUser/iventcard_in_profile.dart';
import '../widget/listvideo.dart';

ListView postclien(BuildContext context, controllecr, id, postnumber) {
    return ListView(
              children: [
                SizedBox(height: heightphon(context,size: 0.19)),
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

 
                  const SizedBox(height: 30,),
                            
                  SizedBox(
                    width: widthphon(context),
                    child:   iventinprofileclien(id),),
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
                         
                    

         ],),
                   ),
// POST profile 
GetBuilder<ProfileController>(
                                      init: ProfileController(),
                                      builder: (contt) {
                                        return   contt.idext==0?StreamBuilder(
          stream: firestor.collection('Post').where("uid", isEqualTo:  id).orderBy("time", descending: true).snapshots(),
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
 Get.to(ScreenReelsInProfile( 
      isvideo: false,
      Stream: firestor.collection('Post').where("uid", isEqualTo: items[index]["uid"]).orderBy("time", descending: true), positionvideo: index,));
       
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
             ):// Vidoe profile 
            StreamBuilder(
          stream: firestor.collection('Videos').where("uid", isEqualTo:id).snapshots(),
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
            Get.to(ScreenReelsInProfile( Stream:  firestor.collection('Videos').where("uid", isEqualTo:items[index]["uid"]), positionvideo: index,isvideo: true,));

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
            


        
 ],),
                )
              ],
            );
  }
