import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/ProfileUser/infoprofilebar.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/ProfileUser/menu.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/ProfileUser/postprofile.dart';
import 'package:randolina/const.dart';

import '../../../../../../Controller/ProfileController.dart';
import '../../../../../../Controller/controllerUser.dart';
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
  final UserController _controllerUserr= Get.put(UserController());

@override
  void initState() {
        controllecr.getcontlike(firebaseAuth.currentUser!.uid);
 ins();
    super.initState();
  }
   ins()async{
    await _controllerUserr.getData();
  }
  @override
  Widget build(BuildContext context) {
    getpiceUser();
 var uid= firebaseAuth.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(actions: [ minu(),],
        toolbarHeight: 0,
    

      backgroundColor: Colors.white,elevation: 0,),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body:  RefreshIndicator(onRefresh: ()async{
           return Future.delayed(Duration(seconds: 1), (){
setState(() {
              
            });
           });
           },
             child:  Stack(
              children: [ 
                postprofile(context, uid, controllecr, postnumber),

                Container(height: 140,
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
                infoprofile(uid),
            
      
      
      
     
              ],
            
          
        ),
      ),
      
      
      );

  }

 
  
  
}