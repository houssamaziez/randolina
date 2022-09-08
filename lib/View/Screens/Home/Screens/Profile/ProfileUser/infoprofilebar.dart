
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../Controller/ProfileController.dart';
import '../../../../../../const.dart';
 

Padding infoprofile(String uid, context) {
var controllerMessanger= Get.put(ControllerMessanger());
      controllerMessanger.getmsegeNosee( uid);
    return Padding(
              padding:   EdgeInsets.only(top:25),
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
                           ],
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
                          padding: const EdgeInsets.only(top: 25, left: 10),
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
    mainAxisAlignment: MainAxisAlignment.start,
      children: [    
              emailwed(items),
               wilayawed(items),
    ],
    ) 
         ],
                          ),
                        );
}

Padding wilayawed(List<QueryDocumentSnapshot<Object?>> items) {
  return Padding(
                            padding:  const EdgeInsets.only(left: 15, bottom: 20),
                            child: Text(items[0]["wilaya"], style: const TextStyle(color:Colors.grey, fontSize: 15),),
        );
}

Padding emailwed(List<QueryDocumentSnapshot<Object?>> items) {
  return Padding(
                            padding:  const EdgeInsets.only(left: 15),
                            child: Text(items[0]["email"], style: const TextStyle(color:Colors.grey, fontSize: 15),),
        );
        
}



bottun({
  required title ,required color,required function, width
}){

  return InkWell(onTap: function,
    child: Container(
    
    decoration: BoxDecoration(
     gradient: LinearGradient(
             begin: Alignment.centerLeft,
             end: Alignment.centerRight,
           
             colors: [
              color.withOpacity(0.4),
              color.withOpacity(0.9),
             ],
           )
         ,
      
    
     borderRadius:const BorderRadius.only(
    
       topLeft: Radius.circular(10),
    
         topRight: Radius.circular(10),
    
         bottomLeft: Radius.circular(10),
    
         bottomRight: Radius.circular(10)
    
     ),
    
     boxShadow: [
    
       BoxShadow(
    
         color: color.withOpacity(0.2),
    
         spreadRadius: 1,
    
         blurRadius: 5,
    
         offset: const Offset(0, 4), // changes position of shadow
    
       ),
    
    
    
     ],
    
    ),
    
     height:27.00, 
    
    width: 80.00,
    
    child:title=="Follow"?     GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return   Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(cont.isfolow==true?"Follow it":"Follow ", style: TextStyle(color:cont.isfolow!=true? Colors.white:Colors.black
                            , fontSize: 12),),
        cont.isfolow!=true?  Image.asset("images/Follow icon500.png", height: 30,): Container()
                            ],
                          ),);
      }
    ):Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return Text(cont.msgevu.toString(), style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),);
                      }
                    ),
                    Text(" Followers", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),),
                  ],
                ),),
    
    ),
  )
;
}