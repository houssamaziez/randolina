import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/save_event_screen.dart';

import '../iventSearch.dart';

AppBar Appbariventhome() {
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
              Get.to(ScreenSearchIvent(tablename:"destination" , docss: "Ivent"));
            },
              child: Container(
                child: Row(children: [
                  IconButton(
                      color: Colors.black,
                      onPressed: (){}, icon: const Icon(Icons.search)),
            
                      const Text("What are you looking for...",style: const TextStyle(color: Colors.grey),)
                ],),
                decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius:const BorderRadius.all(Radius.circular(30))),),
            ),
          ),
        ),
     
        IconButton(
        color: Colors.black,
        onPressed: (){
          Get.to(ScreenSaveEvent());
        }, icon:const Icon(Icons.bookmark)),
        ],);
  }
