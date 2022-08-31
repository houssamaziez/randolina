  import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../Controller/ProfileController.dart';
import '../../../../../../const.dart';

Padding infoproileclien(id) {
    return Padding(
              padding: const EdgeInsets.only(top: 20),
              child:       
                  
                  
                             StreamBuilder(
          stream: firestor.collection('User').where("uid", isEqualTo:id).snapshots(),
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
        return            SizedBox(

                        height: heightphon(context,size: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50,
                            child: Row(children:const [

                              Spacer(),
                             Padding(
                                padding:  EdgeInsets.only(right: 30),
                                child: Text("Profile", style: TextStyle(color:Colors.white, fontSize: 25),),
          ),  Spacer(), 

],),
                              ), 
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children:  [
         SizedBox(height: 90,width: 90,
           child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                child: CachedNetworkImage(width: double.infinity,
                                                                        fit: BoxFit.cover,
                                                                        imageUrl:items[0]["photoProfil"].toString(),
                                                                        placeholder: (context, url) => spinkit,
                                                                        errorWidget: (context, url, error) =>
                                                                            const Icon(Icons.error),
                                                                      ),
                              ),
         ),
                           Padding(
                                padding:  const EdgeInsets.all(8.0),
                                child: Text(items[0]["name"], style: const TextStyle(color:Colors.white, fontSize: 25),),
          ),
          ],
                                ),
                              ) ,
                             Padding(
                                  padding:  const EdgeInsets.only(left: 15),
                                  child: Text(items[0]["email"], style: const TextStyle(color:Colors.grey, fontSize: 17),),
          ),
                             Padding(
                                  padding:  const EdgeInsets.only(left: 15),
                                  child: Text(items[0]["wilaya"], style: const TextStyle(color:Colors.grey, fontSize: 17),),
                                      ),
                           const Padding(
                                  padding:  EdgeInsets.only(left: 15),
                                  child: Text("Bio: ", style: TextStyle(color:Colors.grey, fontSize: 17),),
                                      ),
                                Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(height: 50,
         child: Row(children:[
                            const Spacer(),
                            Padding(
                              padding:  const EdgeInsets.all(8.0),
                              child: GetBuilder<ProfileController>(
                                init: ProfileController(),
                                builder: (contt) {
                                  return Text("${contt.postlength.toString()} posts", style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),);
                                }
                              ),
                            ),const VerticalDivider(color: Colors.white),
                            Padding(
                              padding:  const EdgeInsets.all(8.0),
                              child: followers(context, id),
                            ),const VerticalDivider(color: Colors.white),
                        GetBuilder<ProfileController>(
                                init: ProfileController(),
                                builder: (contt) {
                                  return Text("${contt.likescont.toString()} Likes", style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),);
                                }
                              ),
     
                            const Spacer(),
         ],),),
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
             ),
 );
  }

  followers(BuildContext context, users) {
 return GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return FutureBuilder(
        future:cont.addfollow(users),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
          return  Text("... followers",style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),);
          } else if (snapshot.connectionState == ConnectionState.done) {
              List dataa=snapshot.data;

            if (snapshot.hasError) {
              return  Text("... followers",style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),);
            } else if (snapshot.hasData) {
               return Text(dataa.length.toString()+' followers', style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),);
            } else {
              return   Text("... followers",style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),);
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      );
    }
  );
}

