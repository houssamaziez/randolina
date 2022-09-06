// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/ProfileController.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/postclenprofile.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/widgets.dart';
import 'package:randolina/const.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../Controller/controllerUser.dart';
import '../../Reels/Postview/screenPost.dart';
import '../../Reels/VideoView/screenVideo.dart';
import '../ProfileUser/infoprofilebar.dart';
import 'infoclien.dart';

class SceenProflileAll extends StatefulWidget {
  final  id,imageprofile,name;
    const SceenProflileAll({Key? key ,required this.id, required this.imageprofile,required this.name}) : super(key: key);
  @override
  State<SceenProflileAll> createState() => _SceenProflileAllState();
}
class _SceenProflileAllState extends State<SceenProflileAll> {
int postnumber=0;
var controllecr=Get.put(ProfileController());
var foloowcontr=Get.put( ControllerMessanger());
  final UserController _controllerUserr= Get.put(UserController());

@override
  void initState() {
  foloowcontr.virffollow(widget. id);
   ins();
    super.initState();
  }
   ins()async{
 var uid= firebaseAuth.currentUser!.uid;

     await   _controllerUserr.getDataclien(widget.id);

  }
  @override
  Widget build(BuildContext context) {
    controllecr.getcontlike(widget. id);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Text("Pizza Hut", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),), 
      Text("Restaurant", style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),), 
    
    ],),

      backgroundColor: Colors.white,elevation: 0,),
      backgroundColor: Colors.white,
      body:  RefreshIndicator(onRefresh: ()async{
            
           return Future.delayed(Duration(seconds: 1), (){
setState(() {
              
            });
           });
           },
             child:  Stack(
              children: [ 
                postclien(context, controllecr,widget. id, postnumber),   Container(height: 140,
                         width: double.infinity,decoration: BoxDecoration(
                          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                          color: Colors.white),), 
                infoprofile(widget.id),
                iconback(context,widget.id,widget.imageprofile,widget.name,),  
                  Padding(
            padding: const EdgeInsets.only(top:20),
            child: IconButton(onPressed: (){
Navigator.pop(context);
}, icon:const Icon(Icons.arrow_back,color:Colors.black, )),
          ),        ],
            
          
        ),
      ),
      
      
      );

  }

 

}