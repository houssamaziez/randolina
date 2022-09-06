import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:randolina/const.dart';

class UserController extends GetxController{
 String typeUser="";
 String typeclien="";
 String follow="";


 getData()async{
 var uid= firebaseAuth.currentUser!.uid;
 DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
typeUser= (userdocs.data()! as Map <String, dynamic>)["typeUser"];
return typeUser;
 }
 
  getDataclien(id)async{

 DocumentSnapshot userdocs=await firestor.collection("User").doc(id).get();
typeclien= (userdocs.data()! as Map <String, dynamic>)["typeUser"];
update();
return typeclien;
 }
}