import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/controllerUser.dart';
import 'package:randolina/Controller/eventController.dart';
import 'package:randolina/Controller/storController.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/Admine/ProfileIventAddmin.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ScreenHome/card/cardivbar.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ScreenHome/card/cardivnt.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ScreenHome/card/listcard.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/addIvent.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ProfileEvntUser.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/editivent.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/iventSearch.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import 'package:randolina/const.dart';

import '../../Profile/profileClien/profileUser.dart';
import 'appBar.dart';
import 'screendata.dart';


enum SegmentType { news, map, paper }
enum TestType { segmentation, max, news }
class ScreenEvents extends StatefulWidget {
  const ScreenEvents({Key? key}) : super(key: key);
  @override
  State<ScreenEvents> createState() => _ScreenEventsState();
}
class _ScreenEventsState extends State<ScreenEvents> {
  TestType initialTestType = TestType.max;
  int initial = 0;
  late int posistion=-1;

  bool isPayment = false;
  int initialValue = 0;
  var uid= firebaseAuth.currentUser!.uid;
  late final CustomSegmentedController<SegmentType> controller;
  StoreController controllerstor= Get.put(StoreController());
  IventsController controllivent= Get.put(IventsController());
  @override
  void dispose() {
posistion=-1;
    super.dispose();
  }
   @override
  void initState() {
    super.initState();
    controller = CustomSegmentedController();
    controller.addListener(() {

      print('listener ${controller.value}');
    });
 
ins();
  }
  ins()async{
    await controllerUser.getData();
  }
    BorderRadius dynamicBorder = const BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
  );
  @override
  Widget build(BuildContext context) {
    var _listscreenAll= [
         screenstordata(isall:false, isuser: "HikingClub", controllivent:  controllivent ) ,
      
        screenstordata(isall:false , isuser: "User", controllivent:  controllivent),
 screenstordata(isall:true , controllivent:  controllivent, ),
];
 var _listscreen= [
        screenstordata(isall:false , isuser: "User"),
        screenstordata(isall:true ),
];
    return Scaffold(backgroundColor: Colors.white,
      appBar: Appbariventhome(),
       body: RefreshIndicator(onRefresh: ()async{
            
           return Future.delayed(Duration(seconds: 1), (){
             setState(() {
              
            });
           });
           },
             child: ListView(
            children: [
            const SizedBox(height: 20),
            // All events && My events
              chosen(),
         GetBuilder<UserController>(
          init: UserController(),
           builder: (context) {
             return Container(child:context.typeUser=="HikingClub"?_listscreenAll[initial]:_listscreen[initial] );
           }
         ),
          ],
          ),
       ),);
  
  
         }

  
    chosen() {
    
    return Center(
            child: GetBuilder<UserController>(
        init: UserController(),
              builder: (context) {
                return CustomSlidingSegmentedControl<int>(
                  initialValue: initial,
                  height: 24,
                  children:context.typeUser=="HikingClub"?  {
                    0:   Text('My events part'),
                    1:   Text('Participant'),
                     2:  Text('All events'),

                  }:{
                   0 :  Text('Participant'),
                    1 :  Text('All events'),
                  },
                  decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        offset: const Offset(
                          0.0,
                          2.0,
                        ),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  onValueChanged: (v) {
                    setState(() {
                      initial = v;
                      posistion=-1;
                    });
                  },
                );
              }
            ),
          );
  }

   } 
   
  