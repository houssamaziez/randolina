
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../Controller/ProfileController.dart';
import '../../../../../../const.dart';
import '../profileClien/infoclien.dart';

Padding infoprofile(String uid) {
var controllerMessanger= Get.put(ControllerMessanger());

      controllerMessanger.getmsegeNosee( uid);

    return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: StreamBuilder(
          stream: firestor.collection('User').where("uid",isEqualTo:uid ).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var items = snapshot.data?.docs ?? [];
 if (snapshot.connectionState == ConnectionState.waiting) {
      return Column(children:const [ Spacer(),
        spinkit,
         Spacer(), Spacer(), Spacer(), Spacer(),
        
        ],);
    } else if (snapshot.connectionState == ConnectionState.active
        || snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        return SizedBox(
                    height: heightphon(context,size: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Row(
                            children: [
                              
                              SizedBox(width: 60,),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Text(items[0]["name"], style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),), 
      Text(items[0]["typeUser"]=="HikingClub"?"Hiking Club":(items[0]["typeUser"]=="Store"?"Restaurant":"User"), style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),), 
    ],),
                        followers(context, items[0]["uid"])     ],
                          ),
                          photoProfile(items, items[0]["uid"],context)
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

Padding photoProfile(List<QueryDocumentSnapshot<Object?>> items,id , context) {
  return Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10),
                          child: Row(
                            children:  [
                              SizedBox(width: 10,),
                             SizedBox(height: 90,width: 90,
                               child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                child: Container(
               
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(decoration: BoxDecoration(boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.8),
      spreadRadius:4,
      blurRadius: 5,
      offset: Offset(0, 5), // changes position of shadow
    ),
  ],),
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
                                  ),
                                ),
                                                           ),
                             ),
    Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [            Padding(
                              padding:  const EdgeInsets.only(left: 15),
                              child: Text(items[0]["email"], style: const TextStyle(color:Colors.grey, fontSize: 15),),
          ),
               Padding(
                              padding:  const EdgeInsets.only(left: 15),
                              child: Text(items[0]["wilaya"], style: const TextStyle(color:Colors.grey, fontSize: 15),),
          ),
        Row(
          children: [
      id!=firebaseAuth.currentUser!.uid?      Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child:  GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return  InkWell(onTap: ()async{
     if (cont.isfolow==true ){
Get.defaultDialog(
  cancel: TextButton(onPressed: ()async{
 Navigator.pop(context);

            }, child: Text("Cancel")) ,
            confirm: TextButton(onPressed: ()async{
 await cont.deletemsgeFollow(users: id,  );
 await cont.virffollow(id);

            }, child: Text("Confirm")),
            title:"Delete follow",
           
           content: Center(child: Text("Be careful when deleting a follower, messages will be deleted", textAlign: TextAlign.center,)));
     }else{
      showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child:Center(child: Text("wait a little bit"))
        ),
       
      );
    },
  );
      await cont.sendmessageToAll(users:  id, idmsg: "0", msg: "New follower", isfolew: false);
 await cont.virffollow(id);
 cont.retundata( id);
Navigator.pop(context);
     } 
           
       

      },
        child: Container(
                      
                      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain,
                        
                        image: AssetImage("images/Rectangle 101800.png"))),
                      width: 100,height: 35,
                      child:   Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cont.isfolow==true?"Follow it":"Follow ", style: TextStyle(color: Colors.white, fontSize: 12),),
    cont.isfolow!=true?  Image.asset("images/Follow icon500.png", height: 30,): Container()
                        ],
                      ),),),
      );
                }
              ),
            ) : SizedBox()
   , Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Container(
                
                decoration: BoxDecoration(image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("images/Rectangle 34800 (1).png"))),
                width: 100,height: 35,
                child:   Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return Text(cont.msgevu.toString(), style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),);
                      }
                    ),
                    Text(" Followers", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),),
                  ],
                ),),),
            ),
          ],
        ),
    ],
    ) 
         ],
                          ),
                        );
}

