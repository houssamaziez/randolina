

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ProfileEvntUser.dart';
import '../../../../../../Controller/controllerUser.dart';
import '../../../../../../const.dart';
import '../../Events/Admine/ProfileIventAddmin.dart';
  iventinprofile(uidd) {
  return GetBuilder<UserController>(init:UserController() ,
    builder: (cont) {
    return cont.typeUser=='HikingClub'?    StreamBuilder(
          stream: firestor.collection('Ivent').where("uid", isEqualTo: uidd).orderBy("time", descending: true).snapshots(),
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
          SizedBox(height: 203,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Events :', style: TextStyle(fontSize: 17),),
                ),
                Expanded(
                  child: ListView.builder(shrinkWrap: true,
                              itemCount: items.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, indext){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(onTap: (){
                  Get.to( ()=>firebaseAuth.currentUser!.uid!=items[indext]['uid']? ProfileEventUser(image: items[indext]['urlImage'], tag: indext.toString(), list:  items[indext]): ProfileEvent(image: items[indext]['urlImage'], tag: indext.toString(), list:  items[indext]));
                                },
                                  child: Card(
                                    color: Colors.grey,
                                    child: Stack(
                                      children: [
                                        Container(height: 200,width: 300,
                                        child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(5),),
                                                    child:Hero(tag: indext.toString(),
                                                      child: CachedNetworkImage(
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                                                      fit: BoxFit.cover,
                                                                                      imageUrl:items[indext]['urlImage'].toString(),
                                                                                      placeholder: (context, url) => spinkit,
                                                                                      errorWidget: (context, url, error) =>
                                                                                          const Icon(Icons.error),
                                                                                    ),
                                                    ),
                                            ),),
                                             Positioned(right: 0,bottom: 0,left: 0,
                                               child: Padding(
                                               padding: const EdgeInsets.all(8.0),
                                               child: Align(alignment: Alignment.bottomCenter,
                                                     child:   Container(child: Text(items[indext]['destination'], style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),)),
                                               ),
                                             ),
                                             ),
                                         
                                         Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Align(alignment: Alignment.topLeft,
                                        child:   Container(
                                          child: Center(child: Text(" "+items[indext]['datedubte'], 
                                          maxLines: 1,  overflow: TextOverflow.fade,textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold, color: Colors.black54),),),
                                          decoration: BoxDecoration(
                                            
                                            borderRadius: BorderRadius.all(Radius.circular(70)),
                                            color: Colors.white.withOpacity(0.44),),
                                          height: 50,width: 68,)
                                  ),
                                           ),
                                         Positioned(right: 0,top: 0,
                                        child:  RotatedBox(
                                                quarterTurns: 4,
                                          child: Image.asset("images/Rectangle.png",)),
                                      ),
                                   Positioned(right: -3,top: 20,
                                        child:    Transform(
                                        // ignore: sort_child_properties_last
                                        child:  Padding(
                                          padding:  EdgeInsets.all(8.0),
                                          child:  Text(
                                             items [indext]['price']+"DA",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        alignment: FractionalOffset.center,
                                        transform: new Matrix4.identity()
                                          ..rotateZ(0.88),
                                      ),
                                  ),
                                      ],
                                    ),),
                                ),
                              );
                            }),
                ),
              ],
            ),
          );        
      } else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
 }
             ): Container();
    }
  );
}