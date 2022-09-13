import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenchat.dart';
import 'package:randolina/const.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';


class MessageProduct extends StatelessWidget {
  const MessageProduct({Key? key,required this.image,
  required this.tag,required this.iduser,
  required this.username,required this.imageprofile,required this.pricee, this.detials}) : super(key: key);
final image, tag, iduser, username, imageprofile, pricee, detials;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: ListView(children: [
Stack(
  children: [
        Container(
    
      width: widthphon(context),
    
      height: heightphon(context, size: 0.6),
    
      
    
      decoration:const BoxDecoration(
    
    
   
        borderRadius: BorderRadius.only(
    
        bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),
    
        )
    
      ),
      child: ClipRRect(
                                              borderRadius:  const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40)),
                                              child:Hero(
        tag: image.toString(),
        
        child: CachedNetworkImage(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                                                fit: BoxFit.cover,
                                                                                imageUrl:image.toString(),
                                                                                placeholder: (context, url) => spinkit,
                                                                                errorWidget: (context, url, error) =>
                                                                                    const Icon(Icons.error),
                                                                              ),
                                              ),
              ),
    
    ),
 
 Padding(
   padding: const EdgeInsets.all(8.0),
   child: CircleAvatar(backgroundColor: Colors.white,
     child: Padding(
       padding: const EdgeInsets.only(left: 3),
       child: IconButton(onPressed: (){
        Get.back();
       }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
     ),
   ),
 )
  ],
)
,SizedBox(height: 20,),
const Padding(
  padding: EdgeInsets.all(8.0),
  child:   Text('Specification', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
),SizedBox(height: 20,),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(
    children: [
      Text('Name:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
   Spacer() 
   ,
    Text("""list["name"]""", style: TextStyle(fontSize: 15,color: Colors.grey, fontWeight: FontWeight.bold),),
    SizedBox(width: 8,)],
  ),
),
SizedBox(height: 20,),

const Padding(
  padding: EdgeInsets.all(8.0),
  child:   Text('Option :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
),  Padding(
  padding: EdgeInsets.all(8.0),
  child:   Text(detials, style: TextStyle(fontSize: 15,color: Colors.grey, fontWeight: FontWeight.bold),),
),
 
  SizedBox(height: 20,),  
    Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(
    children: [
      Text('price:', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
     Spacer() 
   ,
    Text(pricee+" DA", style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),),],
 
  ),
),
  ],),
    );
  }
}