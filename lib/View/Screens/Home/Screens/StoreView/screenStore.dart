// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/storController.dart';
import 'package:randolina/View/Screens/Home/Screens/StoreView/profileStore.dart';

enum SegmentType { news, map, paper }

enum TestType { segmentation, max, news }
class ScreenStore1 extends StatefulWidget {
  const ScreenStore1({Key? key}) : super(key: key);

  @override
  State<ScreenStore1> createState() => _ScreenStore1State();
}

class _ScreenStore1State extends State<ScreenStore1> {
    TestType initialTestType = TestType.max;
  int initial = 0;
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
    final listscreen= [
 screenstordata(list:listdata ),screenstordata(list:listAll ),
];

    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),) ,
        backgroundColor: Colors.white,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius:const BorderRadius.all(Radius.circular(30))),
                child: Row(children: [
                  IconButton(
          color: Colors.black,
          onPressed: (){}, icon: const Icon(Icons.search)),

          const Text("What are you looking for...",style: TextStyle(color: Colors.grey),)
                ],),),
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
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const SizedBox(height: 20),
            Center(
              child: CustomSlidingSegmentedControl<int>(
                initialValue: initial,
                height: 24,
                children: const {
                  0: Text('My product'),
                  1: Text('All products'),
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
              ),
            ),
       
       Container(child: listscreen[initial]),
       
        ],
        ),);
  }

  Column screenstordata({required list}) {
    return Column(
children: [
 Padding(
 padding:  const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: Container(
 decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.only(
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
  children: const [Spacer(),
    Text("Add"),
    Icon(Icons.add),Spacer(),

  ],
),
 ),
 )
, GridView.count(
 physics: const NeverScrollableScrollPhysics(),
crossAxisCount: 2,
childAspectRatio: (2 / 2.5),
shrinkWrap: true,
children: List.generate(list.length, (index) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkWell(
      onTap: (){
        Get.to(ProfileProduct(image: list[index]["image"].toString(), tag: index.toString(), list: list[index]));
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
            child: Hero(tag: index.toString(),
              child: Container(height: double.infinity,width: double.infinity,
              decoration: BoxDecoration(
              color: Colors.grey[600],image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(list[index]["image"].toString())),
                borderRadius:const BorderRadius.all(Radius.circular(5))),
                child:Column(children: [
                      Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                       children: [
                         CircleAvatar(backgroundColor: Colors.grey,radius: 24,
                       backgroundImage: NetworkImage(list[index]["imageprofile"].toString()),),
                       const SizedBox(width: 10,), 
                       Text(list[index]["title"].toString(),
                       style:const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white),),
                      ],
              ),
                      ),
                      const Spacer(),
                      Container(width: double.infinity,
                      height: 50,
                      color: Colors.white.withOpacity(0.5),
                      child: Center(child: Text("${list[index]["price"]} DA",
                       style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black),),),)
                      ],),),
            ),),
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
    ),);}),
)
 ],
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