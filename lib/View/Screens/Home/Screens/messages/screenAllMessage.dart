import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/widgets.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenchat.dart';
import 'package:randolina/View/Widgets/search.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

import '../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../const.dart';

class ScreenAllMessage extends StatefulWidget {
   ScreenAllMessage({Key? key}) : super(key: key);

  @override
  State<ScreenAllMessage> createState() => _ScreenAllMessageState();
}

class _ScreenAllMessageState extends State<ScreenAllMessage> {
var controllerMessanger= Get.put(ControllerMessanger());
@override
  void initState() {
      controllerMessanger.getdata();print(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(minutes:1), (){
      controllerMessanger.getdata();
      setState(() {
      });
    });
    return Scaffold(
floatingActionButton: FloatingActionButton(
  backgroundColor: color1,
  onPressed: (){
// Get.to(const ScreenSearch(docs: "User",tablename: "name",));
  }, child: const Icon(Icons.search),),
       appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
        title:const Text("All Messages", style: TextStyle(color: Colors.black),),centerTitle: true,
        shape:const RoundedRectangleBorder(
      borderRadius:  BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),) ,
        backgroundColor: Colors.white,
    ),
    
       body:bodymsges() );
  }

  FutureBuilder<dynamic> cardmsge(List<dynamic> j , msg, time, msgid) {
      var dateFormat = DateFormat.jm();
    print("______${j[0]}_______");
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
)    ; 
        },
          child: ListTile(
                leading: SizedBox(width: 50,height: 50,
                  child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                        child: CachedNetworkImage(width: double.infinity,
                                                                                fit: BoxFit.cover,
                                                                                imageUrl:snapshot2.data["photoProfil"].toString().toString(),
                                                                                placeholder: (context, url) => spinkit,
                                                                                errorWidget: (context, url, error) =>
                                                                                    const Icon(Icons.error),
                                                                              ),
                                      ),
                ),
                                    title: Text(snapshot2.data["name"].toString()),
                                    subtitle:Text(msg.toString()) ,trailing:Text(dateFormat.format(DateTime.parse(time))   .toString()) ,
              ),
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