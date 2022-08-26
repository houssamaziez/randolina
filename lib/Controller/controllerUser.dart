import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:randolina/const.dart';

class UserController extends GetxController{
 String typeUser="";


 getData()async{
 var uid= firebaseAuth.currentUser!.uid;
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
typeUser= (userdocs.data()! as Map <String, dynamic>)["typeUser"];
return typeUser;
 }
 
}