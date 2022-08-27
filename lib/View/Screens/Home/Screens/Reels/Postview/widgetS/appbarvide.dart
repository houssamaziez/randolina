 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Controller/videocotroller.dart';

GetBuilder<VideoController> appbarvideo() {
    return GetBuilder<VideoController>(init:VideoController() ,
                          builder: (cont) {
                            return Row(
                              children: [
                                        const  Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Text( "Images", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            )  ,
                                Image.asset(  cont.isvscrenvideoddd== true?"images/switch (3).png":"images/switch (2).png"),
                          const  Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Text( "Videos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            )  ,],
                            );
                          }
                        );
  }
    