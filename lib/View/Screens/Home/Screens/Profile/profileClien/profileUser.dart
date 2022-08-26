// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/ProfileController.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/postclenprofile.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/widgets.dart';
import 'package:randolina/const.dart';

import '../../Reels/Postview/screenPost.dart';
import '../../Reels/VideoView/screenVideo.dart';
import 'infoclien.dart';

class SceenProflileAll extends StatefulWidget {
  final data ,id,imageprofile,name;
    const SceenProflileAll({Key? key,required this.data,required this.id, required this.imageprofile,required this.name}) : super(key: key);
  @override
  State<SceenProflileAll> createState() => _SceenProflileAllState();
}
class _SceenProflileAllState extends State<SceenProflileAll> {
int postnumber=0;
var controllecr=Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    controllecr.getcontlike(widget. id);
    return Scaffold(
      backgroundColor: color1,
      body:  Stack(
            children: [ 
              infoproileclien(widget.id),
              postclien(context, controllecr,widget. id, postnumber),
              iconback(context,widget.id,widget.imageprofile,widget.name ),  
                      ],
          
        
      ),
      
      
      );

  }

 

}