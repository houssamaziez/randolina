import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:randolina/Controller/controllerUser.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Controller/AuthonticationController.dart';


String nameservice="unwrapped-ceremony.000webhostapp.com";
String urlserverfile=  "https://$nameservice/phptest/addfile.php";
String urlserverlogine=  "https://$nameservice/phptest/logine.php";
String urlserverGetpost= "https://$nameservice/phptest/postview.php";
// var firebase 
FirebaseAuth firebaseAuth= FirebaseAuth.instance;
FirebaseStorage firebaseStorage= FirebaseStorage.instance;
FirebaseFirestore firestor= FirebaseFirestore.instance;
ControllerAth controllerath=ControllerAth.instance;
// state screen
 heightphon(context,{double  size =1.0}){
  return MediaQuery.of(context).size.height*size;
 }
  widthphon(context,{size =1}){
  return MediaQuery.of(context).size.height*size;
 }
//  Colors 
Color color1= const Color.fromARGB(255, 32, 78, 115);
Color color2= const Color.fromARGB(255, 3, 74, 132);
Color color3= const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4);

const spinkit = SpinKitSpinningLines(
  color: Colors.blue,
  size: 50.0,
);const spinkitwhite = SpinKitSpinningLines(
  color: Colors.white,
  size: 50.0,
);
const minispinkit = SpinKitSpinningLines(
  color: Colors.blue,
  size: 20.0,
);


GetStorage islogin= GetStorage();
GetStorage message= GetStorage();
GetStorage messgaenosee= GetStorage();


class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}

var post=firestor.collection('Post').orderBy("time", descending: true);

  UserController controllerUser= Get.put(UserController());
var shape=  const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    ),) ;




    launchCaller(String num) async {
    String  url = "tel:$num";   
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
       await launchUrl (Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }   
}