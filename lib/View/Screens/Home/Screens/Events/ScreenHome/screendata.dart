
    import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../../../Controller/controllerUser.dart';
import '../../../../../../const.dart';
import '../addIvent.dart';
import 'card/listcard.dart';

screenstordata({required isall, isuser, controllivent} ) {
  var uid=firebaseAuth.currentUser!.uid;
    return GetBuilder<UserController>(
        init: UserController(),
      builder: (context) {
        return Column(
children: [
   context.typeUser=="HikingClub"? Padding(
 padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: InkWell(onTap: (){
  Get.to(AddIvent());
 },
   child: Container(
   decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:const BorderRadius.only(
          topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
 
        ],
 ),
 child: Row(
        children: [const Spacer(),
          const Text("Add"),
          const Icon(Icons.add),const Spacer(),
        ],
 ),
        height: 40, 
   width: double.infinity,
   ),
 ),
 )
:Container(),
              StreamBuilder(
                stream:isall==true? firestor.collection('Ivent').where("time",isGreaterThan:DateTime.now()).snapshots():
                (
                   isuser=="HikingClub"?
                   firestor.collection('Ivent').where("uid",isEqualTo:uid).orderBy("time", descending: true).snapshots()
                   :
                   firestor.collection("User").doc(uid).collection("participate").orderBy("time", descending: true).snapshots()
                
                ),
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
              return  listCard(items, uid, controllivent);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
 }
                   ),
 const SizedBox(height: 100,)
 ],
);
      }
    );
  }
