// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/storController.dart';
import 'package:randolina/View/Screens/Home/Screens/StoreView/addStore.dart';
import 'package:randolina/View/Screens/Home/Screens/StoreView/appBar.dart';
import 'package:randolina/View/Screens/Home/Screens/StoreView/profileStore.dart';

import '../../../../../Controller/controllerUser.dart';
import '../../../../../const.dart';

enum SegmentType { news, map, paper }

enum TestType { segmentation, max, news }
class ScreenStore1 extends StatefulWidget {
  const ScreenStore1({Key? key}) : super(key: key);

  @override
  State<ScreenStore1> createState() => _ScreenStore1State();
}

class _ScreenStore1State extends State<ScreenStore1> {
    TestType initialTestType = TestType.max;
  int initial = 1;
  bool isPayment = false;
  int initialValue = 0;
  late int posistion=-1;
  late final CustomSegmentedController<SegmentType> controller;
  StoreController controllerstor= Get.put(StoreController());
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
      // ignore: avoid_print
      print('listener ${controller.value}');
    });
  }
    BorderRadius dynamicBorder = const BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
  );
  @override
  Widget build(BuildContext context) {
 final list=[liststorecard(isall: false, isuser: 'Store'),liststorecard(isall: false,isuser: ''), liststorecard(isall: true, isuser: '')];
 final listAll=[liststorecard(isall: false,isuser: ''), liststorecard(isall: true, isuser: '')];
    
    return Scaffold(backgroundColor: Colors.white,
      appBar:AppbarStorehome(),
       body: RefreshIndicator(onRefresh: ()async{
            
           return Future.delayed(Duration(seconds: 1), (){
             setState(() {
              
            });
           });
           },
             child: ListView(
            children: [
             GetBuilder<UserController>(
        init: UserController(),
      builder: (context) {
                  return Container(child:   context.typeUser=="Store"? Padding(
 padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: InkWell(onTap: (){
  Get.to(AddStore());
 },
   child: Container(
   decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:const BorderRadius.only(
          topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
 
        ],
 ),
        height: 40, 
   width: double.infinity,
 child: Row(
        children:const[ Spacer(),
           Text("Add"),
           Icon(Icons.add), Spacer(),
        ],
 ),
   ),
 ),
 )
:Container(),);
                }
              ),
            const SizedBox(height: 20),
            // All events && My events
              chosen(),
             GetBuilder<UserController>(
          init: UserController(),
           builder: (context) {
                  return context.typeUser=="Store"?list[initial]:listAll[initial];
                }
              ),
 
          ],
          ),
       ),);
  
  
         }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> liststorecard({
    required isall,required isuser,
  }) {
    var uid= firebaseAuth.currentUser!.uid;
    return StreamBuilder(
              stream: isall==true? firestor.collection('Store').orderBy("time", ).snapshots():
                (
                   isuser=="Store"?
                   firestor.collection('Store').where("uid",isEqualTo:uid).orderBy("time", descending: true).snapshots()
                   :
                   firestor.collection("User").doc(uid).collection("requests").orderBy("time", descending: true).snapshots()
                
                ),
              
              
               
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                var items = snapshot.data?.docs ?? [];
              
               if (snapshot.connectionState == ConnectionState.waiting) {
                        return   const Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: spinkit,
                        );
                      } else if (snapshot.connectionState == ConnectionState.active
                          || snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return  GridView.count(
               physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: (2 / 2.5),
              shrinkWrap: true,
              children: List.generate(items.length, (index) {
              return Padding(
              padding: const EdgeInsets.all(10.0),
              child: cardStors(items, index),);}),
              );
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
               }
                 );
  }
  
  InkWell cardStors(list, int index) {
    return InkWell(
    onTap: (){
      Get.to(ProfileProduct(image: list[index]["urlimage"].toString(), tag: index , list: list[index]));
    },
    onLongPress: (){

controllerstor.delletpost();
setState(() {
posistion=index;
 });
  },

    child: Stack(
      children: [
        Card(
          child:         Stack(
            children: [
              Container(height: double.infinity,width: double.infinity,
                                    child: ClipRRect(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(5),),
                                                child:Hero(tag: list[index]["urlimage"].toString(),
                                                  child: CachedNetworkImage(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                                                  fit: BoxFit.cover,
                                                                                  imageUrl:list[index]["urlimage"].toString(),
                                                                                  placeholder: (context, url) => spinkit,
                                                                                  errorWidget: (context, url, error) =>
                                                                                      const Icon(Icons.error),
                                                                                ),
                                                ),
                ),),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(radius: 25,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(height: 50,width: 50,
          
                     child:  ClipRRect(
          
                                                          borderRadius: const BorderRadius.all(
          
                                                            Radius.circular(1000),),
          
                                                          child:Hero(tag: index.toString(),
          
                                                            child: CachedNetworkImage(
          
                                                              height: double.infinity,
          
                                                              width: double.infinity,
          
                                                                                            fit: BoxFit.cover,
          
                                                                                            imageUrl:list[index]["urlimage"].toString(),
          
                                                                                            placeholder: (context, url) => spinkit,
          
                                                                                            errorWidget: (context, url, error) =>
          
                                                                                                const Icon(Icons.error),
          
                                                                                          ),
          
                                                          ),
          
                          ), ),
        ),
      ),
  SizedBox(width: 8,),
  
    Container(child:Stack(
  children: <Widget>[
    // Stroked text as border.
    Text(
      list[index]["username"].toString(),
      style: TextStyle(
        fontSize: 16,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..color = Color.fromARGB(255, 0, 0, 0),
      ),
    ),
    // Solid text as fill.
    Text(
      list[index]["username"].toString(),
      style: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    ),
  ],
)
                     
                     
                       ),
               
   ],
  ),
), 
            Align(alignment: Alignment.bottomCenter,
              child: Container(width: double.infinity,
                    height: 50,
                    color: Colors.white.withOpacity(0.5),
                    child: Center(child: Text("${list[index]["price"]} DA",
                     style:const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black),),),),
            ) ],
          ),
   ),
     posistion==index?Padding(
       padding: const EdgeInsets.all(5.0),
       child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.withOpacity(0.7),
        child: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, ),
            child: Container(
              width: double.infinity,height: 40,
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: const Center(child:
             Text('Delete',
             style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
          ),
 Padding(
            padding: const EdgeInsets.only(left: 20, right: 20,top: 20 ),
            child: Container(
              width: double.infinity,height: 40,
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child:const Center(child:
             Text('Edit',
             style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
          ),
          const  Spacer(),

          ],
        ),)),
     ):Container()
      ],
    ),
  );
  }


  chosen() {
    
    return Center(
            child: GetBuilder<UserController>(
        init: UserController(),
              builder: (context) {
                return CustomSlidingSegmentedControl<int>(
                  initialValue: initial,
                  height: 24,
                  children:context.typeUser=="Store"?  {
                    0:   Text('My product'),
                    1:   Text('My requests'),
                     2:  Text('All products'),
                  }:{
                   0 :  Text('My requests'),
                    1 :  Text('All products'),
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



 var listdata = [
  {
"image":'https://media-cdn.tripadvisor.com/media/photo-s/15/03/79/e3/otto-s-anatolian-food.jpg',
"title":"Restaurant",
"price":1500,
"imageprofile":'https://filehandler.revlocal.com/424926'
 },
  {
"image":'https://www.thaqfny.com/wp-content/uploads/2021/09/%D8%A8%D9%8A%D8%AA%D8%B2%D8%A7.gif',
"title":"Restaurant",
"price":2000,
"imageprofile":'https://filehandler.revlocal.com/424926'
 }, {
"image":'https://www.ennaharonline.com/wp-content/uploads/2021/09/5-49.jpg',
"title":"Restaurant",
"price":1800,
"imageprofile":'https://filehandler.revlocal.com/424926'
 },
 {
"image":'https://s.hdnux.com/photos/01/17/50/04/20873528/3/rawImage.jpg',
"title":"Restaurant",
"price":3000,
"imageprofile":'https://filehandler.revlocal.com/424926'
 },
 ];

 
 var listAll = [
   {
"image":'https://www.la-vie-naturelle.com/media/magefan_blog/junk-food.jpg',
"title":"Restaurant",
"price":4000,
"imageprofile":'https://image.shutterstock.com/image-vector/restaurant-logo-creative-260nw-272549726.jpg'
 }, {
"image":'https://media-cdn.tripadvisor.com/media/photo-s/1c/b8/78/d5/kabobi-persian-and-mediterrane.jpg',
"title":"Restaurant",
"price":1500,
"imageprofile":'https://image.shutterstock.com/image-vector/restaurant-logo-creative-260nw-272549726.jpg'
 }, 
  {
"image":'https://www.thaqfny.com/wp-content/uploads/2021/09/%D8%A8%D9%8A%D8%AA%D8%B2%D8%A7.gif',
"title":"Restaurant",
"price":2000,
"imageprofile":'https://filehandler.revlocal.com/424926'
 }, {
"image":'https://www.ennaharonline.com/wp-content/uploads/2021/09/5-49.jpg',
"title":"Restaurant",
"price":1800,
"imageprofile":'https://filehandler.revlocal.com/424926'
 },
 {
"image":'https://download.vikidia.org/vikidia/fr/images/a/a4/Pizza.jpg',
"title":"Restaurant",
"price":2800,
"imageprofile":'https://filehandler.revlocal.com/424926'
 },
  {
"image":'https://media-cdn.tripadvisor.com/media/photo-s/15/03/79/e3/otto-s-anatolian-food.jpg',
"title":"Restaurant",
"price":1500,
"imageprofile":'https://filehandler.revlocal.com/424926'
 },
 {
"image":'https://s.hdnux.com/photos/01/17/50/04/20873528/3/rawImage.jpg',
"title":"Restaurant",
"price":3000,
"imageprofile":'https://image.shutterstock.com/image-vector/restaurant-logo-creative-260nw-272549726.jpg'
 },
 {
"image":'https://download.vikidia.org/vikidia/fr/images/a/a4/Pizza.jpg',
"title":"Restaurant",
"price":1000,
"imageprofile":'https://filehandler.revlocal.com/424926'
 },
  {
"image":'https://media-cdn.tripadvisor.com/media/photo-s/15/03/79/e3/otto-s-anatolian-food.jpg',
"title":"Restaurant",
"price":1500,
"imageprofile":'https://filehandler.revlocal.com/424926'
 }, {
"image":'https://www.la-vie-naturelle.com/media/magefan_blog/junk-food.jpg',
"title":"Restaurant",
"price":4000,
"imageprofile":'https://filehandler.revlocal.com/424926'
 }, {
"image":'https://media-cdn.tripadvisor.com/media/photo-s/1c/b8/78/d5/kabobi-persian-and-mediterrane.jpg',
"title":"Restaurant",
"price":1500,
"imageprofile":'https://image.shutterstock.com/image-vector/restaurant-logo-creative-260nw-272549726.jpg'
 }, {
"image":'https://download.vikidia.org/vikidia/fr/images/a/a4/Pizza.jpg',
"title":"Restaurant",
"price":2800,
"imageprofile":'https://filehandler.revlocal.com/424926'
 },
 ];
