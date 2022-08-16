import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/controllerUser.dart';
import 'package:randolina/Controller/iventController.dart';
import 'package:randolina/Controller/storController.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ProfileIventAddmin.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/addIvent.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ProfileEvntUser.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/editivent.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import 'package:randolina/ct.dart';
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
  bool isPayment = false;
  int initialValue = 0;
  var uid= firebaseAuth.currentUser!.uid;
  late int posistion=-1;
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
         screenstordata(isall:false, isuser: "HikingClub"  ) ,
      
        screenstordata(isall:false , isuser: "User"),
 screenstordata(isall:true ),
];
 var _listscreen= [
        screenstordata(isall:false , isuser: "User"),
        screenstordata(isall:true ),
];
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        shape:const RoundedRectangleBorder(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),) ,
        backgroundColor: Colors.white,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Container(
                child: Row(children: [
                  IconButton(
          color: Colors.black,
          onPressed: (){}, icon: const Icon(Icons.search)),

          const Text("What are you looking for...",style: const TextStyle(color: Colors.grey),)
                ],),
                decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius:const BorderRadius.all(Radius.circular(30))),),
            ),
          ),
          IconButton(
          color: Colors.black,
          onPressed: (){}, icon:const Icon(Icons.filter_alt)),
          IconButton(
          color: Colors.black,
          onPressed: (){}, icon:const Icon(Icons.bookmark)),
          ],),
       body: ListView(
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

    screenstordata({required isall, isuser}) {
    return GetBuilder<UserController>(
        init: UserController(),
      builder: (context) {
        return Column(
children: [
   context.typeUser=="HikingClub"? Padding(
 padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: InkWell(onTap: (){
  Get.to(AddIvent());
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
 child: Row(
        children: [const Spacer(),
          const Text("Add"),
          const Icon(Icons.add),const Spacer(),
        ],
 ),
        height: 40, 
   width: double.infinity,
   ),
 ),
 )
:Container(),
              StreamBuilder(
                stream:isall==true? firestor.collection('Ivent').where("time",isGreaterThan:DateTime.now()).snapshots():
                (
                   isuser=="HikingClub"?
                   firestor.collection('Ivent').where("uid",isEqualTo:uid).orderBy("time", descending: true).snapshots()
                   :
                   firestor.collection("User").doc(uid).collection("participate").orderBy("time", descending: true).snapshots()
                
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
              return  ListView.builder(
  shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
  itemCount:items.length ,
  itemBuilder: ((context, index) => 
cardivent(items, index, context)
));
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
 }
                   ),
 const SizedBox(height: 100,)
 ],
);
      }
    );
  }

    Padding cardivent(List<QueryDocumentSnapshot<Object?>> items, int index, BuildContext context) {
      return Padding(
padding: const EdgeInsets.all(8.0),
child:   InkWell(onTap: (){

  Get.to( ()=>uid!=items[index]['uid']? ProfileEventUser(image: items[index]['urlImage'], tag: index.toString(), list:  items[index]): ProfileEvent(image: items[index]['urlImage'], tag: index.toString(), list:  items[index]));
},
  child: Card(elevation: 16,
    child: Stack(
      children: [
        Container(
          width: widthphon(context),
        height: 300,
        decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5))
        
        ),
        child: Column(children: [const SizedBox(height: 10,), 
  barcard(items[index]),const SizedBox(height: 10,), 
          Expanded(
            flex: 3,
            child: ClipRRect(
          
                                    borderRadius: const BorderRadius.only(
          
                                        bottomLeft: Radius.circular(5),
          
                                        bottomRight: Radius.circular(5)),
          
                                    child:Stack(
                                      children: [
                                        Hero(
                                          tag: index.toString(),
                                          child: CachedNetworkImage(width: double.infinity,
                                                                      fit: BoxFit.cover,
                                                                      imageUrl:items[index]['urlImage'].toString(),
                                                                      placeholder: (context, url) => spinkit,
                                                                      errorWidget: (context, url, error) =>
                                                                          const Icon(Icons.error),
                                                                    ),
                                        ),
                                 
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Align(alignment: Alignment.bottomCenter,
        child:   Container(child: Text(items[index]['destination'], style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),)),
  ),
                                   ),            Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Align(alignment: Alignment.topLeft,
        child:   Container(
          child: Center(child: Text(" "+items[index]['datedubte'], 
          overflow: TextOverflow.fade,textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold, color: Colors.black54),),),
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white.withOpacity(0.6),),
  
          
          height: 50,width: 100,)
  ),
                                   ),
           ],
                                    ),
                                    
                                    
                                    
                                
          )),
        ],),
        
        ),
         Positioned(
      top: 55,left: 0, 
      right: 0,
      child: Center(
        child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(1000),),
                                    child:CircleAvatar(radius: 40,backgroundColor: Colors.grey,
                                      child: Container(height: 90,width: 90,
                                        child: CachedNetworkImage(width: double.infinity,
                                                                    fit: BoxFit.cover,
                                                                    imageUrl:items[index]['photouser'].toString(),
                                                                    placeholder: (context, url) => spinkit,
                                                                    errorWidget: (context, url, error) =>
                                                                        const Icon(Icons.error),
                                                                  ),
                                      ),
           ),
        ),
      )
      ) , 
      Positioned(right: 0,top: 0,
        child:  RotatedBox(
                quarterTurns: 4,
          child: Image.asset("images/Rectangle.png",)),
      ),
   Positioned(right: -3,top: 20,
        child:    Transform(
        // ignore: sort_child_properties_last
        child:  Padding(
          padding:  EdgeInsets.all(8.0),
          child:  Text(
             items [index]['price']+"DA",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        alignment: FractionalOffset.center,
        transform: new Matrix4.identity()
          ..rotateZ(0.88),
      ),
  ),
     ],
    ),
  ),
),
);
    }
   barcard(items) {
    return Expanded(child: Container(
child: Column(children: [ Text(items['username'], style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),const Spacer(),
Row(children: [
bottun(title:uid==items['uid']?"Edit":(items['participate'].contains(uid)?"Annuler": 'Participate'), color:items['participate'].contains(uid)?Colors.red: Colors.blue , 

function: (){
uid==items['uid']?  Get.to(EditIvent(
    datedubteivent: items['time'],
    imagurl:items['urlImage'] ,
    details:items["details"]  , destination: items["destination"], price1:items["price"]  , distance:items["distance"]  , nombresplaces:items["nombresplaces"] , datedubte:items["datedubte"] , datefine:items["datefine"] , id:items["id"],   ))
: Get.defaultDialog(title: "Participate",
content: Text(items['participate'].contains(uid)?"Do you want to cancel your participation in the trip?":'Do you want to confirm your participation in the trip?'),
  cancel: TextButton(onPressed: (){
Get.back();
}, child: const Text("cancel")),
  confirm: TextButton(onPressed: (){
  controllivent.participer(idpost:items['id'], list:items  );
Get.back();
}, child: const Text("confirm")));
}),
 ],)
],),
));
  }
}