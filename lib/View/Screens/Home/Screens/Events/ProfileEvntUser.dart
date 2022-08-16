
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/addIvent.dart';
import 'package:randolina/ct.dart';

import '../../../../../Controller/iventController.dart';

class ProfileEventUser extends StatelessWidget {
   ProfileEventUser({Key? key,required this.image,required this.tag,required this.list}) : super(key: key);
// ignore: prefer_typing_uninitialized_variables
final list;
  IventsController controllivent= Get.put(IventsController());

var uid=firebaseAuth.currentUser!.uid;
final String image, tag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Container(width: double.infinity,height: 100,
          
          child: Row(children: [ 
            Padding(
        padding:  EdgeInsets.only(left: 20, ),
        child: Text(list['price'].toString()+" DA", style: TextStyle( color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w900),),
      ),
            Expanded(child: buttonivnt(function:(){

              
uid==list['uid']?Get.defaultDialog(title: "Edit",
content: const Text('Edit'),
  cancel: TextButton(onPressed: (){
Get.back();
}, child: const Text("cancel")),
  confirm: TextButton(onPressed: (){
Get.back();
}, child: const Text("confirm"))): Get.defaultDialog(title: "Participate",
content: Text(list['participate'].contains(uid)?"Do you want to cancel your participation in the trip?":'Do you want to confirm your participation in the trip?'),
  cancel: TextButton(onPressed: (){
Get.back();
}, child: const Text("cancel")),
  confirm: TextButton(onPressed: (){
  controllivent.participer(idpost:list['id'], list: list );
Get.back();

Get.back();


}, child: const Text("confirm")));


}, ))
          ],),
          ),),
      ),
       body: Stack(
         children: [
           _imagback(context),
            ListView(children: [
             
            Container(
                
                height: heightphon(context, size: 0.5),
    ),
           Container(
                decoration:const BoxDecoration(
                               color: Color.fromARGB(255, 245, 245, 245),
                     borderRadius:  BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)),
                ),
   
   child: Padding(
     padding: const EdgeInsets.only(right: 20,left: 20 ),
     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
      
      Padding(
        padding:  EdgeInsets.only(top: 40, ),
        child: Text(list['destination'], style: TextStyle( color: Colors.black87, fontSize: 30, fontWeight: FontWeight.bold),),
      ),
      SizedBox(height: 20,),
      suptitle(title: "Description :"),
      
      
     Padding(
        padding:  EdgeInsets.only(top: 5,left: 10 ),
        child: Text(list['details'], style: TextStyle( color: Colors.black45, fontSize: 17, fontWeight: FontWeight.bold),),
      ),
      SizedBox(height: 20,),
      suptitle(title: "informations principales :"),
      
      SizedBox(height: 20,),
      suptitle(title: "Départ :"),
      
     Padding(
        padding:  EdgeInsets.only(top: 5,left: 10 ),
        child: Text(list['datedubte'].toString(), style: TextStyle( color: Colors.black45, fontSize: 17, fontWeight: FontWeight.bold),),
      ),
       SizedBox(height: 20,),
      suptitle(title: "Retour :"),
      
     Padding(
        padding:  EdgeInsets.only(top: 5,left: 10 ),
        child: Text(list['datefine'].toString(), style: TextStyle( color: Colors.black45, fontSize: 17, fontWeight: FontWeight.bold),),
      ),
        SizedBox(height: 20,),
      suptitle(title: "Distance de marche :"),
      
     Padding(
        padding:  EdgeInsets.only(top: 5,left: 10 ),
        child: Text(list['distance'].toString()+"Km", style: TextStyle( color: Colors.black45, fontSize: 17, fontWeight: FontWeight.bold),),
      ),
        SizedBox(height: 20,),
      suptitle(title: "Nombres des places :"),
      
     Padding(
        padding:  EdgeInsets.only(top: 5,left: 10 ),
        child: Text(list['nombresplaces'].toString(), style: TextStyle( color: Colors.black45, fontSize: 17, fontWeight: FontWeight.bold),),
      ),
        SizedBox(height: 30,),
      
      ],),
   ),
   
   ),
            ],)
        , Padding(
 padding: const EdgeInsets.only(top: 25, left: 20),
 child: CircleAvatar(backgroundColor: Colors.white,
   child: Padding(
         padding: const EdgeInsets.only(left: 3),
         child: IconButton(onPressed: (){
          Get.back();
         }, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
   ),
 ),
 )
 ],
       ),
    );
  }

  Column _imagback(BuildContext context) {
    return Column(children: [
  Container(
    width: widthphon(context),
    height: heightphon(context, size: 0.6),
    
    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      child: Hero(
                              tag: tag,
                              child: CachedNetworkImage(width: double.infinity,
                                                          fit: BoxFit.cover,
                                                          imageUrl:list['urlImage'].toString(),
                                                          placeholder: (context, url) => spinkit,
                                                          errorWidget: (context, url, error) =>
                                                              const Icon(Icons.error),
                                                        ),
                            ), ),
  ),
 ],);
  }

 

  Padding buttonivnt({required function}) {
    return Padding(
 padding:  const EdgeInsets.only(left: 50, right: 10, top: 15, bottom: 15),
 child: InkWell(onTap: function,
   child: Container(
   decoration: BoxDecoration(
 color:list['participate'].contains(uid)?Colors.red: Colors.blue,
 borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10)
 ),
 boxShadow: [
    BoxShadow(
      color: list['participate'].contains(uid)?Colors.red.withOpacity(0.3): Colors.blue.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 3), // changes position of shadow
    ),
 
 ],
 ),
 child:   Center(child: GetBuilder<IventsController>(
  init: IventsController(),
   builder: (control) {
     return control.islodeinImage==true?spinkit:   Text(list['participate'].contains(uid)?"Annuler": 'Participate',style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),);
   }
 ),),
 height: double.infinity, 
   width: double.infinity,
   ),
 ),
 );
  }


}