import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/ProfileUser/infoprofilebar.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/ProfileUser/menu.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/ProfileUser/postprofile.dart';
import 'package:randolina/const.dart';

import '../../../../../../Controller/ProfileController.dart';
import '../../Reels/Postview/screenPost.dart';
import '../../Reels/VideoView/screenVideo.dart';

class SceenProflile extends StatefulWidget {

    SceenProflile({Key? key}) : super(key: key);

  @override
  State<SceenProflile> createState() => _SceenProflileState();
}

class _SceenProflileState extends State<SceenProflile> {
 var  piceUser= "";

getpiceUser()async{
  var uid= firebaseAuth.currentUser!.uid;
  DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
  print((userdocs.data()! as Map <String, dynamic>)["photoProfil"]);
piceUser=   (userdocs.data()! as Map <String, dynamic>)["name"];
print(piceUser);
 return await (userdocs.data()! as Map <String, dynamic>)["photoProfil"];
}

int postnumber=0;
var controllecr=Get.put(ProfileController());
@override
  void initState() {
        controllecr.getcontlike(firebaseAuth.currentUser!.uid);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getpiceUser();
 var uid= firebaseAuth.currentUser!.uid;
    return Scaffold(
      backgroundColor: color1,
      body:  Stack(
            children: [ 
              infoprofile(uid),
          
              postprofile(context, uid, controllecr, postnumber),



minu(),
            ],
          
        
      ),
      
      
      );

  }

 
  
  
}