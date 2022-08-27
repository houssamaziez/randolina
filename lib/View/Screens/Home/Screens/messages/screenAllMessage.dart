import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      controllerMessanger.getdata();
    controllerMessanger.getmsegeNosee();

       message.write("msg", 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   Timer(const Duration(seconds:10), (){
  
      setState(() {
      });
    });
    return Scaffold(
floatingActionButton: FloatingActionButton(
  backgroundColor: color1,
  onPressed: (){
Get.to(ScreenSearch(docs: "User",tablename: "name",));
  }, child: const Icon(Icons.search),),
       appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          
        }, icon: const Icon(Icons.arrow_back, color: Colors.black,)),
        title:const Text("All Messages", style: TextStyle(color: Colors.black),),centerTitle: true,
        shape:const RoundedRectangleBorder(
      borderRadius:  BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),) ,
        backgroundColor: Colors.white,
    ),
       body:
       
       bodymsges() );
  }
  FutureBuilder<dynamic> cardmsge(List<dynamic> j , msg, time, msgid) {
      var dateFormat = DateFormat.jm();
    print("${j[0]}");
    return FutureBuilder(future:controllerMessanger.getdatauser(j[0]),
            builder: (context,AsyncSnapshot snapshot2 ) {
        print("---DDD---"+snapshot2.data.toString());
                if (snapshot2.connectionState == ConnectionState.waiting) {
       return errordata();
      
    } else if (snapshot2.connectionState == ConnectionState.done) {
      if (snapshot2.hasError) {
        return errordata();
      } else if (snapshot2.hasData) {
        return InkWell(onTap:(){
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
        print("---DDD---"+snapshot.data.toString());

                if (snapshot.connectionState == ConnectionState.waiting) {

       return errordata();
      
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return errordata();
      } else if (snapshot.hasData) {
        return GetBuilder<ControllerMessanger>(init: ControllerMessanger(),
         builder: (cont) {
           return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
            String data ="";
            List j=snapshot.data[index]["users"].where((element) => element != firebaseAuth.currentUser!.uid.toString()).toList();
            //  var c=j.sort((a,b)=> a["time"].compareTo(b[DateTime.now().toString()])) as List;
            return SizedBox(
              child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(onTap: (){
        print("hhhhhhhhhhhhhhhhh${snapshot.data[index]["msg"]}");

 },
        child: Card(
          child:cardmsge(j , snapshot.data[index]["msg"] , snapshot.data[index]["time"],snapshot.data[index]["msgid"] )
        ),
      ),
    ));
 
  });
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

    
}







 

  ListTile errordata() {
    return ListTile(
              leading: SizedBox(width: 50,height: 50,
                child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                      child: Image.asset('images/user.png')
                                    ),
              ),
                                  title: const Text('loading ...'),
                                  subtitle:const Text("loading ....") ,
            );
  }