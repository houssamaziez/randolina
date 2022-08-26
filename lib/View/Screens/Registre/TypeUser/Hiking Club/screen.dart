import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/AuthonticationController.dart';
import 'package:randolina/const.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../widgets.dart';

class ScreenHikingClub extends StatefulWidget {
final typeUser;
 final title;
  const ScreenHikingClub({Key? key, this.title,required this.typeUser}) : super(key: key);

  @override
  State<ScreenHikingClub> createState() => _ScreenHikingClubState();
}

class _ScreenHikingClubState extends State<ScreenHikingClub> {

  late String _username,_email,_password,_phone,_wilaya;
var ky = GlobalKey();
   @override
  Widget build(BuildContext context) {

    var listscrren=[
  
  //  screen 1
   Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(children: [
   GetBuilder<ControllerAth>(init: ControllerAth(),
     builder:(cont)=> Container( 
        height: 140,width: 140,
           decoration:BoxDecoration(
            image:controllerath.image==null?const  DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/CAM.png")):DecorationImage(
              fit: BoxFit.cover,
              image:FileImage(File(cont.image!.path))),
              borderRadius:const BorderRadius.all(Radius.circular(2000))),
              child: InkWell(onTap: (() {
          setState(() {
                  controllerath.pickImage();
          });
              }),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 9.6, top: 6),
                      child: Container(
                         height: 121,width: 121,
                       decoration:  BoxDecoration(
                       color: Colors.white.withOpacity(0.35),
                borderRadius: BorderRadius.all(Radius.circular(2000))),
                      ),
                    ),
                    Column(children: [
                   const Spacer(),
                     const Spacer(),
                   const  Text("Upload picture", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                    Center(child: Icon(Icons.upload_sharp, color: Colors.black.withOpacity(0.8),size: 35,)),
                   const Spacer(),
                    ],),
                  ],
                ),
              ),),
   )
   ,
      textfield(
        
        onChanged: (val){
        setState(() {
        _username=val;
      });
      },title: "User Name...."),
      textfield(onChanged: (val){
        setState(() {
        _email=val;
      });
      },title: "email...."),
      textfield(onChanged: (val){
        setState(() {
        _wilaya=val;
      });
      },title: "Wilaya...."),
      textfield(onChanged: (val){
        setState(() {
        _password=val;
      });
      },title: "Password...."),
      textfield(onChanged: (val){
        setState(() {
        _phone=val;
      });
      },title: "phone"),
      SizedBox(height: 15,),
     ],),
   ) ,
  
  
  // screen 2
   Container(
    height: MediaQuery.of(context).size.height*0.5,
     child: Column(children: [Spacer(),
     
    const Text("to confirm your number , enter the SMS \n code here :",
     style: TextStyle(color: Colors.white70
     ,fontSize: 17    , 
     ),

      textAlign: TextAlign.center,),
      SizedBox(height: 20,),
        textfield(onChanged: (val){},title: "CODE...."),
        Spacer(),
     ],),
   ) ,
  
  
  //  bio
  Column(children: [
  textfield(onChanged: (val){},
                title: "Bio...."
                ),
                 CHOSE(),

                
             ],) ,
               

];

    return Container(decoration:const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("images/BACK1.png"))
    ),
      child: Scaffold(backgroundColor: Colors.transparent,
        appBar: appbar(function: (){
if (stp==0) {
  Get.back();
}else{
setState(() {
  stp--;
});}

        }, isback: true),
     
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
        
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Center(
                      child: Container(height: 5,width: double.infinity,color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Container(height: 40,width:   double.infinity,
                  child: Row(children:  [
                  stp==0 ?Container() : Spacer(),
                    
                    Padding(
                    padding:   EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,backgroundColor: listcolors[stp],
                    child: Center(child: Image.asset("images/sp$stp.png", height: 14,)),
                    ),
                  ),
                 stp==2 ?Container() : Spacer(),
        
                  ],),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              
           listscrren[stp],
             Row(
          children: [
          const  Spacer(),
        
          GetBuilder<ControllerAth>(init:ControllerAth() ,
            builder:(contr) =>  contr.isloadingSignin ==true?Padding(
              padding: const EdgeInsets.only(right: 50),
              child: spinkit,
            ):button(title: 'Next', istrue: true,
            
            function: ()async{
                      uploadVideo( videoFile) async{
          contr.index(true);
  var data;
    var uri = Uri.parse(urlserverfile);
    var request = new MultipartRequest("POST", uri);
    var multipartFile = await http. MultipartFile.fromPath("files", videoFile);
    request.files.add(multipartFile);
    StreamedResponse response = await request.send();
  response.stream.transform(utf8.decoder).listen((value) {
             
   controllerath.registreUser(uerlimage:value,
                username: _username,
               email:_email,typeUser:widget. typeUser,
                password: _password,
              phone:_phone ,
              wilaya: _wilaya,
              );
    });
              contr.index(false);
 

    if(response.statusCode==200){
      print("Video uploaded");
    }else{
      print("Video upload failed");

      return data;

    }
  }
              var c=await uploadVideo( controllerath.path);   
  
                // stp++;
                  
                 }
                 
                 ),
          ),
          ],
              )
            
              ],
          ),
        ),),
    );
    
  }

  Padding CHOSE() {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  
                  height: heg.toDouble(),width: double.infinity,
                  decoration:  BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius:const BorderRadius.all(Radius.circular(15))),
                  
                  child: ListView(children: [
                  const  SizedBox(height: 10,),
                    InkWell(onTap: (){
                    setState(() {
if (heg== 200) {
heg= 50;
}else{
heg= 200;

}                      });
                  },
                      child: Padding(
                        padding:const  EdgeInsets.all(8.0),
                        child: Row(
                          children:const [
                            Text("Chose...."),Spacer(),
                    
                            Icon(Icons.arrow_drop_down),
                        SizedBox(height: 20,),
                    
                          ],
                        ),
                      ),
                    ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        choslist(title: "Photographer", function: (){
                           setState(() {if (heg== 200) {heg= 50;}else{heg= 200;}  });
                        }),
                        choslist(title: "Vloger", function: (){
                           setState(() {if (heg== 200) {heg= 50;}else{heg= 200;}  });

                        }),
                        choslist(title: "Hikinger", function: (){
                           setState(() {if (heg== 200) {heg= 50;}else{heg= 200;}  });

                        }),
                        choslist(title: "Videos maker", function: (){
                           setState(() {if (heg== 200) {heg= 50;}else{heg= 200;}  });

                        }),
                        choslist(title: "Athlete", function: (){
                           setState(() {if (heg== 200) {heg= 50;}else{heg= 200;}  });

                        }),
                        choslist(title: "Tourist", function: (){
                           setState(() {if (heg== 200) {heg= 50;}else{heg= 200;}  });

                        }),
                        choslist(title: "Others..", function: (){
                           setState(() {if (heg== 200) {heg= 50;}else{heg= 200;}  });

                        }),
                      ],),
                    ),
                  )
                  ],),
                ),
              );
  }

  InkWell choslist({title, function}) {
    return InkWell(onTap: function,
                        child: Container(
                          
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      
                            children: [
                              Text(title),SizedBox(height: 10,),
                                Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(height: 10,),
                            ],
                          ),),
                      );
  }
  
}

var listcolors=[
Colors.red,
Color.fromARGB(255, 255, 159, 75),
Color.fromARGB(255, 24, 248, 32),

];

int stp=0;

var heg=50.0;