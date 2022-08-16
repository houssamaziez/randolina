import 'package:cloud_firestore/cloud_firestore.dart';

class User {
// var
  String name, typeUser , email , password ,uid , photoProfil,wilaya, phone;

// constractr
  User(
{ required   this.name,
  required  this.email,
  required  this.typeUser,
  required  this.wilaya,
  required  this.phone,
  required  this.password,
 required   this.uid,
 required   this.photoProfil,}
     );


// functon change data to form jeson 
     Map<String, dynamic> toJson()=>{
"name":name,
"email":email,
"typeUser" :typeUser,
"password":password,
"uid":uid,
"phone":phone,
"wilaya":wilaya,

"photoProfil":photoProfil,
     };


     static User fromsnap(DocumentSnapshot snap){
      var snapshot=snap.data() as Map <String , dynamic>;
      return User(
        phone:snapshot["phone"] ,
        typeUser:snapshot["typeUser"] ,
        wilaya:snapshot["wilaya"] ,
        name: snapshot["name"],
       email:  snapshot["email"],
       password: snapshot["password"],
       uid: snapshot["uid"],
        photoProfil: snapshot["photoProfil"]
        );
     }
}