import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/save_event_screen.dart';
import 'package:randolina/View/Screens/Home/Screens/StoreView/storeSearch.dart';

import '../Events/iventSearch.dart';


AppBar AppbarStorehome() {
    return AppBar(
      shape:const RoundedRectangleBorder(
    borderRadius: const BorderRadius.vertical(
      bottom: Radius.circular(30),
    ),) ,
      backgroundColor: Colors.white,
      actions: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: InkWell(onTap: (){
              Get.to(ScreenSearchStors(tablename:"name" , docss: "Store"));
            },
              child: Container(
                decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius:const BorderRadius.all(Radius.circular(30))),
                child: Row(children: [
                  IconButton(
                      color: Colors.black,
                      onPressed: (){}, icon: const Icon(Icons.search)),
            
                      const Text("What are you looking for...",style:  TextStyle(color: Colors.grey),)
                ],),),
            ),
          ),
        ),
     
         
        ],);
  }
