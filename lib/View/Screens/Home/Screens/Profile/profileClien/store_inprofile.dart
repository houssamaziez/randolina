  import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/controllersearch.dart';

import '../../../../../../const.dart';
import '../../StoreView/profileStore.dart';

  storerest(uidd) {
     InkWell _card( items, index) {
    return InkWell(
  onTap: (){
    Get.to(ProfileProduct(tokenD: "".toString() ,
       imageprofile: items[index]["userphoto"].toString(),
        username:items[index]["username"].toString(),
                  iduser: items[index]["uid"].toString(),

      image: items[index]["urlimage"].toString(), tag: items , list: items[index]));
  },
  onLongPress: (){

// controllerstor.delletpost();
 
},

  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(height: 100,width: 160,
      child: Stack(
        children: [
          Card(
            child:         Stack(
              children: [
                Container(height: double.infinity,width: double.infinity,
                                      child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(5),),
                                                  child:Hero(tag: items[index]["urlimage"].toString(),
                                                    child: CachedNetworkImage(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                                                    fit: BoxFit.cover,
                                                                                    imageUrl:items[index]["urlimage"].toString(),
                                                                                    placeholder: (context, url) => spinkit,
                                                                                    errorWidget: (context, url, error) =>
                                                                                        const Icon(Icons.error),
                                                                                  ),
                                                  ),
                  ),),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        CircleAvatar(radius: 25,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(height: 50,width: 50,
            
                       child:  ClipRRect(
            
                                                            borderRadius: const BorderRadius.all(
            
                                                              Radius.circular(1000),),
            
                                                            child:Hero(tag: index.toString(),
            
                                                              child: CachedNetworkImage(
            
                                                                height: double.infinity,
            
                                                                width: double.infinity,
            
                                                                                              fit: BoxFit.cover,
            
                                                                                              imageUrl:items[index]["urlimage"].toString(),
            
                                                                                              placeholder: (context, url) => spinkit,
            
                                                                                              errorWidget: (context, url, error) =>
            
                                                                                                  const Icon(Icons.error),
            
                                                                                            ),
            
                                                            ),
            
                            ), ),
          ),
        ),
    SizedBox(width: 8,), Text(items[index]["username"].toString(), style: TextStyle(color: Colors.white,),) ],
    ),
    ), 
              Align(alignment: Alignment.bottomCenter,
                child: Container(width: double.infinity,
                      height: 50,
                      color: Colors.white.withOpacity(0.5),
                      child: Center(child: Text("${items[index]["price"]} DA",
                       style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black),),),),
              ) ],
            ),
     ),
      ],
      ),
    ),
  ),
);
  }
 
    return GetBuilder<ControllerSearch>(
            init: ControllerSearch(),
            builder: (cont) {
              // ignore: unnecessary_null_comparison
                 return StreamBuilder(
            stream: firestor.collection("Store").where("uid", isEqualTo: uidd).snapshots(),
                        builder:  (context, AsyncSnapshot<QuerySnapshot> snapshot){
              var items = snapshot.data?.docs ?? [];
print(items);
if (snapshot.connectionState == ConnectionState.waiting) {
        return     Padding(
          padding:   EdgeInsets.only(top: heightphon(context, size: 0.4)),
          child: spinkit,
        );
      } else if (snapshot.connectionState == ConnectionState.active
          || snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return        GetBuilder<ControllerSearch>(
            init: ControllerSearch(),
            builder: (cont) {
              // ignore: unnecessary_null_comparison
                 return Container(height: 200,
                   child: Container(height: 200,width:200,
                     child: ListView.builder(scrollDirection:Axis.horizontal ,
                      itemCount:items.length ,
                      shrinkWrap: true,
                      itemBuilder: 
                     (contex, index){
                      // return Text(index.toString());
                      return  _card(items, index);
                     }
                     ),
                   ),
                 );
 
            }
          );
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }

                       }
                      );
    }
  );
  
  }
