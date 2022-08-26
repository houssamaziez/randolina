// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/imagecontroller.dart';
import 'package:randolina/View/Screens/Registre/widgets.dart';
import 'package:randolina/const.dart';


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
            onPressed: ()async{
              if (contr.islodeinImage==false) {
                
           uploadVideo( videoFile) async{
  var data;
    var uri = Uri.parse(urlserverfile);
    var request = new MultipartRequest("POST", uri);
    var multipartFile = await http. MultipartFile.fromPath("files", videoFile);
    request.files.add(multipartFile);
    StreamedResponse response = await request.send();
  StreamSubscription<String> f=  response.stream.transform(utf8.decoder).listen((value) {
               uploadvideocontroller.uploadImage(
                Imageurl: value,
                detailspost: details, imagepath:uploadvideocontroller.imagefile as File );

    });
 

    if(response.statusCode==200){
      print("Video uploaded");

      return data;
    }else{
      print("Video upload failed");

      return data;

    }
  }
   
              var c=await uploadVideo(contr.image);   
              print("_______$c");
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