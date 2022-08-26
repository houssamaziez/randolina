import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/const.dart';

class ProfileProduct extends StatelessWidget {
  const ProfileProduct({Key? key,required this.image,required this.tag,required this.list}) : super(key: key);
final image, tag, list;
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
      child: Hero(
        tag: tag,
        child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40)),
                              child: Image.network(image, fit: BoxFit.cover,))),
    
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
const Padding(
  padding: EdgeInsets.all(8.0),
  child:   Text('Option :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
),const Padding(
  padding: EdgeInsets.all(8.0),
  child:   Text('Algérienne, Mayaunèse, Ketchup, Sauce blanche.', style: TextStyle(fontSize: 15,color: Colors.grey, fontWeight: FontWeight.bold),),
),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(
    children: [
      Text('Name:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
   Spacer() 
   ,
    Text('Burger Cheese', style: TextStyle(fontSize: 15,color: Colors.grey, fontWeight: FontWeight.bold),),],
  ),
),Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Text('A great Cheese Burger  with deffirent gridient.', style: TextStyle(fontSize: 15,color: Colors.grey, fontWeight: FontWeight.bold),),
),
    
  SizedBox(height: 20,),  
    Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(
    children: [
      Text('price:', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
     Spacer() 
   ,
    Text('${list["price"].toString()} DA', style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),),],
 
  ),
),
  Padding(
 padding:  EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: Container(
 decoration: BoxDecoration(
  color: Colors.blue,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10)
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.blue.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 5,
      offset: Offset(0, 3), // changes position of shadow
    ),

  ],
),
child:   Center(child: Text("Buy Now",style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),),),
  height: 50, 
 width: double.infinity,
 ),
 )
,     ],),
    );
  }
}