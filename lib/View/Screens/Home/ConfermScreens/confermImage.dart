// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/imagecontroller.dart';
import 'package:randolina/View/Screens/Registre/widgets.dart';
import 'package:randolina/ct.dart';

class ConfrImage extends StatefulWidget {
  const ConfrImage({Key? key}) : super(key: key);



  @override
  State<ConfrImage> createState() => _ConfrImageState();
}

class _ConfrImageState extends State<ConfrImage> {
  ImageController uploadvideocontroller= Get.put(ImageController());
String details="";
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1.withOpacity(0.2),
      floatingActionButton: GetBuilder<ImageController>(init: ImageController(),
        builder:(contr)=> Padding(
          padding: const EdgeInsets.only(bottom: 23),
          child: FloatingActionButton(
            backgroundColor: color1,
            onPressed: (){
              if (contr.islodeinImage==false) {
              uploadvideocontroller.uploadImage(detailspost: details, imagepath:uploadvideocontroller.imagefile as File );
                
              }
              },
          
          child:contr.islodeinImage?spinkit: const Icon(Icons.post_add),),
        ),
      ),
      body: SingleChildScrollView(child: SizedBox(
        height: heightphon(context),
        child: Column(children: [
          Expanded(
            child: GetBuilder<ImageController>(
              init: ImageController(),
              builder: (contrr) {
                return Image.file(
                  File(contrr.image, 
                ),fit: BoxFit.contain,);
              }
            ),
          ),
Padding(
  padding: const EdgeInsets.only(right: 75),
  child:   Container(child: 
  
          textfield( onChanged: (val){setState(() {
            details=val;
          });} ,  title: "Details of post", lin: 5)
  
  ,),
)      ],),
      ),),
    );
  }
}