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
      

      backgroundColor: Colors.white,elevation: 0,),
      backgroundColor: Colors.white,
      body:  RefreshIndicator(onRefresh: ()async{
            
           return Future.delayed(const Duration(seconds: 1), (){
setState(() {
              
            });
           });
           },
             child:  Stack(
              children: [ 
                postclien(context, controllecr,widget. id, postnumber), 
                
                  Container(height: 160,
                         width: double.infinity,decoration: BoxDecoration(
                          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                          color: Colors.white),), 
               
                infoprofile(widget.id, context),
               
                  
         Padding(
           padding: const EdgeInsets.only(top: 123, left: 105),
           child: Row(
             children: [
               widget. id!=firebaseAuth.currentUser!.uid?
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child:  GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return  Container(decoration: const BoxDecoration(
        color:  Color.fromARGB(255, 202, 201, 201),
                borderRadius:BorderRadius.only(
    
       topLeft: Radius.circular(10),
    
               topRight: Radius.circular(10),
    
               bottomLeft: Radius.circular(10),
    
               bottomRight: Radius.circular(10)
    
     ),
      ),
        child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(decoration: const BoxDecoration(
                  color: Colors.white,
                    borderRadius:BorderRadius.only(
    
                 topLeft: Radius.circular(10),
    
                   topRight: Radius.circular(10),
    
                   bottomLeft: Radius.circular(10),
    
                   bottomRight: Radius.circular(10)
    
     ),
                ),
                  child: bottun(title: "Follow", color:cont.isfolow==true ?const Color.fromARGB(255, 58, 255, 64): Colors.blue, function: ()async{
     if (cont.isfolow==true ){
Get.defaultDialog(
  cancel: TextButton(onPressed: ()async{
 Navigator.pop(context);

                        }, child: const Text("Cancel")) ,
                        confirm: TextButton(onPressed: ()async{
 await cont.deletemsgeFollow(users:widget. id,  );
 await cont.virffollow(widget. id);

                        }, child: const Text("Confirm")),
                        title:"Delete follow",
                       
                       content: const Center(child: Text("Be careful when deleting a follower, messages will be deleted", textAlign: TextAlign.center,)));
     }else{
                  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
                  return const AlertDialog(
                    content: SingleChildScrollView(
                      child:Center(child: Text("wait a little bit"))
                    ),
                   
                  );
    },
  );
                  await cont.sendmessageToAll(users: widget. id, idmsg: "0", msg: "New follower", isfolew: false);
 await cont.virffollow(widget.id);
 cont.retundata(widget. id);
Navigator.pop(context);
     } 
                  },),
                ),
        ),
      );
                      }
                    ),
                  ) : const SizedBox()
,    Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child:  GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
    builder: (cont) {
      return  Container(decoration: const BoxDecoration(
        color: const Color.fromARGB(255, 202, 201, 201),
                borderRadius:BorderRadius.only(
    
       topLeft: Radius.circular(10),
    
               topRight: Radius.circular(10),
    
               bottomLeft: Radius.circular(10),
    
               bottomRight: Radius.circular(10)
    
     ),
      ),
        child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(decoration: const BoxDecoration(
                  color: Colors.white,
                    borderRadius:BorderRadius.only(
    
                 topLeft: Radius.circular(10),
    
                   topRight: Radius.circular(10),
    
                   bottomLeft: Radius.circular(10),
    
                   bottomRight: Radius.circular(10)
    
     ),
                ),
                  child: bottun(title: "", color:  Colors.white, function: ()async{
     if (cont.isfolow==true ){
Get.defaultDialog(
  cancel: TextButton(onPressed: ()async{
 Navigator.pop(context);

                        }, child: const Text("Cancel")) ,
                        confirm: TextButton(onPressed: ()async{
 await cont.deletemsgeFollow(users: widget. id,  );
 await cont.virffollow(widget. id);

                        }, child: const Text("Confirm")),
                        title:"Delete follow",
                       
                       content: const Center(child: Text("Be careful when deleting a follower, messages will be deleted", textAlign: TextAlign.center,)));
     }else{
                  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
                  return const AlertDialog(
                    content: SingleChildScrollView(
                      child:Center(child: Text("wait a little bit"))
                    ),
                   
                  );
    },
  );
                  await cont.sendmessageToAll(users:  widget. id, idmsg: "0", msg: "New follower", isfolew: false);
 await cont.virffollow(widget. id);
 cont.retundata( widget. id);
Navigator.pop(context);
     } 
                  },),
                ),
        ),
      );
                      }
                    ),
                  ),
             ],
           ),
         ) 
              , 
               
               
               
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