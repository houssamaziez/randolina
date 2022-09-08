import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ScreenHome/screendata.dart';
import 'package:randolina/const.dart';

import '../../../../../Controller/eventController.dart';
import 'ScreenHome/card/cardivnt.dart';
import 'ScreenHome/card/listcard.dart';

class ScreenSaveEvent extends StatelessWidget {
    ScreenSaveEvent({Key? key}) : super(key: key);
  IventsController controllivent= Get.put(IventsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  leading: IconButton(onPressed: (){
  Navigator.pop(context);
  }, icon:const Icon( Icons.arrow_back, color: Colors.black,)),
  centerTitle: true,
  title:const Text('Seve Events', style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
             shape: shape,),
      body:              StreamBuilder(
                stream:firestor.collection("User").doc(firebaseAuth.currentUser!.uid).collection("save").orderBy("time", descending: true).snapshots()
                ,
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
              return  ListView.builder(padding:const EdgeInsets.only(top: 10) ,
itemCount:items.length ,
itemBuilder: ((context, index) => 
cardivent(items, index, context, firebaseAuth.currentUser!.uid, controllivent)
));
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
}