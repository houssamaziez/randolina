import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenchat.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/cardmessage.dart';
import 'package:randolina/View/Widgets/search.dart';
import '../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../const.dart';

class ScreenAllMessage extends StatefulWidget {
   const ScreenAllMessage({Key? key}) : super(key: key);

  @override
  State<ScreenAllMessage> createState() => _ScreenAllMessageState();
}

class _ScreenAllMessageState extends State<ScreenAllMessage> {
var controllerMessanger= Get.put(ControllerMessanger());
@override
  void initState() {
    print("object");
      controllerMessanger.getdata();
      // controllerMessanger.getmsegeNosee(firebaseAuth.currentUser!.uid);
          message.write("msg", controllerMessanger.msgevu);
    print("object");

        print(message.read("msg"));
    print("object");
   
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
floatingActionButton: FloatingActionButton(
  backgroundColor: color1,
  onPressed: (){
Get.to(ScreenSearch(docs: "User",tablename: "name",));
  }, child: const Icon(Icons.search),),
      appBar: appBardALL(context, "Messages"),
       body:
       
       bodymsges() );
  }
  FutureBuilder<dynamic> cardmsge(List<dynamic> j , msg, time, msgid) {
      var dateFormat = DateFormat.jm();
    print("${j[0]}");
   
    return FutureBuilder(future:controllerMessanger.getdatauser(j[0]),
            builder: (context,AsyncSnapshot snapshot2 ) {
              
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  
       return errordata();
      
    } else if (snapshot2.connectionState == ConnectionState.done) {
      if (snapshot2.hasError) {
        return errordata();
      } else if (snapshot2.hasData) {
        return InkWell(onTap:(){
          controllerMessanger.cleanrsltdatamesage();
          Get.to(        ScreenCHat(idclien: j[0], idmsg:msgid ,imageprofile: snapshot2.data["photoProfil"].toString(),  name:snapshot2.data["name"].toString() ,)
              ); 
        },
          child:Cardmessage(controllerMessanger: controllerMessanger,
            snapshot2: snapshot2,msg: msg,dateFormat: dateFormat,time: time),
        );
      } else {
        return errordata();
      }
    } else {
      return Text('State: ${snapshot2.connectionState}');
    }
            
            }
          );
  }
  FutureBuilder<dynamic> bodymsges( ) {
    
    return FutureBuilder(future:controllerMessanger.getdata(),
            builder: (context,AsyncSnapshot snapshot ) {
            // GetStorage _message= GetStorage();
          //  _message.write("listmsg", snapshot);
      
       if (snapshot.connectionState == ConnectionState.waiting) {
            return errordata();
    } 
    else
     if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return errordata();
      } else if (snapshot.hasData) {
        return GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
         builder: (cont) {
           return RefreshIndicator(onRefresh: ()async{
            
           return Future.delayed(Duration(seconds: 1), (){
setState(() {
              
            });
           });
           },
             child: listmessage(snapshot),
           );
         }
       );
    
     } else {
        return errordata();
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
            
            }
          );
  }

  ListView listmessage(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index){
            String data ="";
            List j=snapshot.data[index]["users"].where((element) => element != firebaseAuth.currentUser!.uid.toString()).toList();
            return SizedBox(
              child:Padding(
               padding: const EdgeInsets.all(8.0),
               child: InkWell(onTap: (){
         
          },
                 child: Card(
                   child:cardmsge(j , snapshot.data[index]["msg"] , snapshot.data[index]["time"],snapshot.data[index]["msgid"] )
                 ),
               ),
             ));
          
           });
  }

    
}







 

    errordata() {
 return   Card(
   
   child: ListTile(
     leading: SizedBox(width: 50,height: 50,
       child: ClipRRect(
                             borderRadius: const BorderRadius.all(Radius.circular(1000)),
                             child: Image.asset('images/user.png')
                           ),
     ),
                         title: const Text('loading ...'),
                         subtitle:const Text("loading ....") ,
   ),
 );
  }