import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenchat.dart';
import 'package:randolina/const.dart';

import '../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';

class ProfileProduct extends StatelessWidget {
  const ProfileProduct({Key? key,required this.image,
  required this.tag,required this.list,required this.iduser,
  required this.username,required this.imageprofile,required this.token}) : super(key: key);
final image, tag, list, iduser, username,token, imageprofile;
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
    Text(list["name"], style: TextStyle(fontSize: 15,color: Colors.grey, fontWeight: FontWeight.bold),),
    SizedBox(width: 8,)],
  ),
),
SizedBox(height: 20,),

const Padding(
  padding: EdgeInsets.all(8.0),
  child:   Text('Option :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
),  Padding(
  padding: EdgeInsets.all(8.0),
  child:   Text(list["details"], style: TextStyle(fontSize: 15,color: Colors.grey, fontWeight: FontWeight.bold),),
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
 child: GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return InkWell(onTap: ()async {
      try {
cont.waitsendopject(true);

  await cont.sendmessageToAll(
    token: "",
    users: list["uid"], idmsg: "0", msg: "post", isfolew: false);
   cont.sendmessageToAll(
        token: "",users:list["uid"], msg:
       [
       list["userphoto"], list["username"], list["uid"], list["urlimage"], "tag", list["price"]
       , list["details"],
        list["name"],
        list["id"],
       ]
       
       , idmsg:  cont.rsltdatamesage.length==1?
                   cont.rsltdatamesage[0]["msgid"].toString():"0");
     Get.to( ScreenCHat(token:  "",
      
      idclien:  list["uid"].toString() ,name: username,
             idmsg:   cont.rsltdatamesage.length==1?
                   cont.rsltdatamesage[0]["msgid"].toString():"0", imageprofile: imageprofile,)
         );
cont.waitsendopject(false);
         
    //  await cont.virffollow(id);
} on Exception catch (e) {
cont.waitsendopject(false);

  // TODO
}
   
   },
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
   child:   Center(child:cont.islodingemsg==true?spinkitwhite: Text("Order now",style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),),),
      height: 50, 
     width: double.infinity,
     ),
   );}
 ),
 )
,     ],),
    );
  }
}