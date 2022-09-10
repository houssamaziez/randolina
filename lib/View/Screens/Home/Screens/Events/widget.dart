 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Controller/eventController.dart';
import '../../../../../const.dart';

bottun({
  required title ,required color,required function, width= 80.00, hiegth=27.00, pad=false
}){

  return Padding(
  padding:pad==false? const EdgeInsets.all(8.0):const EdgeInsets.all(0.0),
  child:   InkWell(onTap: function,
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
    
    child:    Center(child: Text(title,style: const TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.bold),),),
    
     height:hiegth, 
    
    width: width,
    
    ),
  ),
)
;
}





  appbarev() {
    return AppBar(leading: IconButton(onPressed: (){
Get.back();
}, icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
      shape:const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    ),) ,
      backgroundColor: Colors.white,
      
      title: const Text("Add a event", style: TextStyle(color: Colors.black),),);
  }



 
   addimage({functon}) {
    return Padding(
 padding:  const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: InkWell(onTap: functon ,
 child: Container(
 decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10)
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 3), // changes position of shadow
    ),
 
  ],
 ),
 child: Column(
  children: [const Spacer(),
    const Text("Upload picture" , style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
 const SizedBox(height: 10,),   const Icon(Icons.upload_sharp, color: Colors.grey,),const Spacer(),
 
  ],
 ),
  height: 90, 
 width: double.infinity,
 ),
 ),
 );
  }

  buttonselcat({  title, function}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: InkWell(onTap: function ,
 child: Container(
 decoration: BoxDecoration(
color: Colors.white,
borderRadius: const BorderRadius.only(
  topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: const Radius.circular(10),
      bottomRight: const Radius.circular(10)
),
boxShadow: [
  BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 3), // changes position of shadow
  ),
 
],
 ),
 child:   title,
height: 60, 
 width: double.infinity,
 ),
 ),
    );
  }


  Padding buttonivnt({required function}) {
    return Padding(
 padding:  const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: InkWell(onTap: function,
   child: Container(
   decoration: BoxDecoration(
 color: const Color.fromARGB(255, 0, 104, 189),
 borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10)
 ),
 boxShadow: [
    BoxShadow(
      color: Colors.blue.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 3), // changes position of shadow
    ),
 
 ],
 ),
 child:   Center(child: GetBuilder<IventsController>(
  init: IventsController(),
   builder: (control) {
     return control.islodeinImage==true?spinkit: const Text("Next",style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),);
   }
 ),),
 height: 50, 
   width: double.infinity,
   ),
 ),
 );
  }

  AppBar appBardALL(BuildContext context, title,{ function}) {
    return AppBar(backgroundColor: Colors.white,
      title: Text(title, style: TextStyle(color: Colors.grey),),
      centerTitle: true,
      leading: IconButton(onPressed: (){
        Navigator.pop(context)
;        }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
      shape: shape,);
  }
