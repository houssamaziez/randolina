  import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

 late AnimationController fabAnimationController;
  late AnimationController borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController hideBottomBarAnimationController;

  int bottomNavIndex = 0; //default index of a first screen

  
  final iconList =  [
    "images/Vector5.png",
    "images/Vector20.png",
    "images/Vector10.png",
    "images/Vector2.png",
  ];
  final iconListactv =  [
    "images/Vector6.png",
    "images/Vector15.png",
    "images/Vector11.png",
    "images/Vector1.png",
 
  ];





  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          hideBottomBarAnimationController.reverse();
          fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          hideBottomBarAnimationController.forward();
          fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }


