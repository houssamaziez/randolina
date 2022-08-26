import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randolina/View/Screens/Registre/widgets.dart';

import 'TypeUser/Hiking Club/screen.dart';
// ignore: prefer_typing_uninitialized_variables
var typeuser;

class ScreenChos extends StatefulWidget {
  const ScreenChos({Key? key}) : super(key: key);

  @override
  State<ScreenChos> createState() => _ScreenChosState();
}

class _ScreenChosState extends State<ScreenChos> {
  @override
  Widget build(BuildContext context) {
       return Scaffold(backgroundColor: Colors.white,
      appBar: appbar(),
    body: Column(
      children: [
         const  Spacer(),
      const Text("Click on the correct option to choose", style: const TextStyle(fontSize: 19 , color: Colors.grey),),

      const  Spacer(),
        Center(
          child: SizedBox(
             height: MediaQuery.of(context).size.height*0.5,
            child: swiper(function:  (){
              setState(() {
                print(indextlist);
              });
      })),
        ),
        const Spacer(),
//  botton next screen  
        button( title: "Next",istrue: indextlist==-1,
          function: (){
          switch (indextlist) {
            case 0:
              Get.to(const ScreenHikingClub(title:"HikingClub" , typeUser:"HikingClub" ,));
              typeuser=0;
              break;
             case 1:
              Get.to(const ScreenHikingClub(title:"User" , typeUser: "User",));

              typeuser=1;

              break;
             case 2:
              Get.to(const ScreenHikingClub(title:"Agency" ,typeUser:"Agency"  ,));
              typeuser=2;

              break;
             case 3:
              Get.to(const ScreenHikingClub(title:"Store" , typeUser: "Agency" ,));
              typeuser=3;
              break;
          
            default:
          }
        }),
     const SizedBox(height: 50,)
      ],
    ),
    );
 
  }
// fontction return  list chos images 

    swiper({function}){
  return  Swiper(
  layout: SwiperLayout.STACK,
  customLayoutOption: CustomLayoutOption(
    startIndex: -1,
    stateCount: 3
  )..addRotate([
    -45.0/180,
    0.0,
    45.0/180
  ])..addTranslate([
    const Offset(-370.0, -40.0),
    const Offset(0.0, 0.0),
    const Offset(370.0, -40.0)
  ]),
  itemWidth: 200.0,
  itemHeight: 400.0,
  itemBuilder: (context, index) {
var listchos=listchoscard[index];
    return InkWell(
      onTap:(){
setState(() {
    indextlist= index;
  
});
      },
      child: Container(
        
         decoration:  BoxDecoration(color:indextlist==index? Colors.blue:Colors.transparent,
            borderRadius:const BorderRadius.all(Radius.circular( 23)),
      ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular( 23)),
            image: DecorationImage(
              fit: BoxFit.cover,
            image: AssetImage(listchos.image, ))),
            child: Column(
              children: [
               const SizedBox(height: 10,),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${listchos.title}" , style:const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 25),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
  itemCount: listchoscard.length,
)
;
}

}