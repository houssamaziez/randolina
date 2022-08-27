 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../const.dart';

GetBuilder<ControllerMessanger> listmessages(idm,idmsg) {
    return GetBuilder<ControllerMessanger>(
          init: ControllerMessanger(),
          builder: (cont) {
            if (cont.rsltdatamesage.length==1) {
                idm=cont.rsltdatamesage[0]["msgid"];
            }else{
              
              idm=idmsg;

 }
            return  StreamBuilder(
            stream: firestor.collection('Massenger').doc(idm.toString()).collection("messages").orderBy("time", descending: true).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var items = snapshot.data?.docs ?? [];
                return ListView.builder(reverse: true,
                       itemCount: items.length,

               shrinkWrap: true,
                 padding: const EdgeInsets.only(top: 10,bottom: 60),
              itemBuilder: (context, index){
  return Container(
    padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
    child: Align(
      alignment: (items[index]["uid"] != firebaseAuth.currentUser!.uid?Alignment.topLeft:Alignment.topRight),
      child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (items[index]["uid"]  != firebaseAuth.currentUser!.uid?Colors.grey.shade200:Colors.blue[200]),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(items[index]["message"], style: const TextStyle(fontSize: 15),),
      ),
    ),
  );
},
);
              }
            );
          }
        );
  }
