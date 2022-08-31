

// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:randolina/Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import 'package:randolina/Controller/imagecontroller.dart';
import 'package:randolina/View/Screens/Home/ConfermScreens/confermVideo.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ScreenHome/screenHomeEvents.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/ProfileUser/screenProfile.dart';
import 'package:randolina/View/Screens/Home/Screens/StoreView/screenStore.dart';
import 'package:randolina/View/Screens/Home/widgetsHome/var.dart';
import 'package:randolina/View/Widgets/BottumCenter.dart';
import 'package:video_compress/video_compress.dart';

import '../../../const.dart';
import 'Screens/Reels/screenHome1.dart';
// var compressvideoInf;

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);



  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}






class _ScreenHomeState extends State<ScreenHome> with TickerProviderStateMixin {
  
 late File videofile;
pickVideo(ImageSource src,  BuildContext context)async{
  
  final video = await ImagePicker().pickVideo(source: src);
String? sizeinisil;
  if (video!=null) {
      Get.to(ConfrVideo(videofile: File(video.path), 
    
    videopath:video.path ,  size:"siz :${await video.length()}\nsiz :${video.length()} ",
    ));
  }

}
  
  @override
  Widget build(BuildContext context) {
   var listScreen=[
      const ScreenReels(),
       const ScreenStore1(),
      const ScreenEvents(),
         SceenProflile(),
];
    return Stack(
      children: [
        listScreen[bottomNavIndex],
        Bottombar(),
      ],
    );
  }

   






// ------------------------- bottom bar -------------------------------


 Bottombar() {
  var controllerImagee=Get.put(ImageController());
    return Stack(
      children: [
        Positioned(bottom: 0,left: 0, right: 0,
          child: SizedBox(height: 60,
            child: Scaffold(backgroundColor: Colors.transparent,
               
        
        
        
               
                floatingActionButton: Image.asset("images/Plus.png",
                 height: 100, width: 50, fit: BoxFit.cover,),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: AnimatedBottomNavigationBar.builder(
                  itemCount: iconList.length,
                  tabBuilder: (int index, bool isActive) {
                    final color = isActive ?color2 : Colors.white;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconList[index],
                          size: 24,
                          color: color,
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          
                        )
                      ],
                    );
                  },
                  backgroundColor: color3,
                  activeIndex: bottomNavIndex,
                  splashColor:color1,
                  notchAndCornersAnimation: borderRadiusAnimation,
                  splashSpeedInMilliseconds: 300,
                  notchSmoothness: NotchSmoothness.defaultEdge,
                  gapLocation: GapLocation.center,
                  leftCornerRadius: 32,
                  rightCornerRadius: 32,
                  
                  onTap: (index) => setState(() => bottomNavIndex = index),
                  hideAnimationController: hideBottomBarAnimationController,
                  shadow:const BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 12,
                    spreadRadius: 0.5,
                    color: Colors.transparent,
                  ),
                ),
              ),
          ),
        ),
        Positioned(
              bottom: 28,
              right: 0,
              left: 0,
              child: Mybottom(
                primaryForegroundColor: Colors.white,
              primaryIconCollapse: Icons.add
              ,primaryIconExpand:Icons.add ,
                    secondaryIconsList:const [
                      Icons.photo,
                      Icons.video_call_sharp,
                    ],
                    secondaryIconsText:const [
                      "Video",
                      "Photo",
                    ],
                    secondaryIconsOnPress: [
                       
                      () => {
                        controllerImagee.pickImage()
                      },
                      () => {
                        pickVideo(ImageSource.gallery, context)

                      },
                    ],
                    secondaryBackgroundColor: Color.fromARGB(255, 112, 107, 107),
                    secondaryForegroundColor: Colors.white,
                    primaryBackgroundColor: color1.withOpacity(0),
                  ),
            ),
     ],
    );
  }
var contrmsg=Get.put(ControllerMessanger());
@override
  void initState() {
    super.initState();
    intial();
  
  }
  
  
  void intial() async{

    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: color3,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
    
    fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    
    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );
    
    hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    
    Future.delayed(
      Duration(seconds: 1),
      () => fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => borderRadiusAnimationController.forward(),
    );
  }

}
