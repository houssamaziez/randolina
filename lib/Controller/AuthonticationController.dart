// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:randolina/Model/user.dart' as model;
import 'package:randolina/View/Screens/Home/Home.dart';
import 'package:randolina/View/Screens/Registre/Signin/screenSignin.dart';
import 'package:randolina/ct.dart';
class ControllerAth extends GetxController{
bool isloadingSignin = false;
bool isloadingLogin = false;
 
@override
  void onReady() {
    super.onReady();
Timer(const Duration(seconds: 3), (){
     if ( islogin.read("islogin")==null|| islogin.read("islogin")==false) {
    Get.offAll(ScreenSignIn());
  }
  else{
    Get.offAll(const ScreenHome());
  }
});
  }
static ControllerAth instance= Get.find();
  //foncton apuload umage to data  base
Future<String>  uploadimage(image)async{
  //  path
Reference ref=   firebaseStorage.ref().child("profilePics").child(firebaseAuth.currentUser!.uid);

// push image to fire storge
 UploadTask uploadt = ref.putFile(image);
 TaskSnapshot snp= await uploadt;
 // ignore: non_constant_identifier_names
 String UrlImage=await snp.ref.getDownloadURL();
return UrlImage;
}
//  Foncton resgitre data of User and Create compte in firebase
void registreUser(
  { required String username ,
  required String email,
  required String password,
  required File? file, 
  required String phone,
  required String wilaya,
  required String typeUser,
   }
)async{
try {
  isloadingSignin= true ;
  update();
  // ignore: unnecessary_null_comparison
  if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && phone.isNotEmpty&& wilaya.isNotEmpty && file !=null){

 // ignore: non_constant_identifier_names
 UserCredential UserCred = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//  get url of image 
 String uerlimage= await uploadimage(file);
//  get data of User
 model.User  user= model.User(typeUser:typeUser ,
  email: email,phone:phone , wilaya: wilaya,
  name:username
  , password: password,
    photoProfil: uerlimage,
      uid:UserCred.user!.uid  );
  
    firestor.collection("User").doc(UserCred.user!.uid ).set(user.toJson() ).then((value) => Get.snackbar("User", "Add User ...")
    );
  }
  islogin.write('islogin', true);
  Get.offAll(()=> const ScreenHome());
isloadingSignin= false ;
  update();
} catch (e) {
isloadingSignin= false ;
  update();
  Get.snackbar("Error" ,e.toString());
  // ignore: avoid_print
  print(e);
}
}
//  file image
late Rx<File?> _pickedImage;
// path image
File? get profilePhoto =>  _pickedImage.value;
// ignore: prefer_typing_uninitialized_variables
var image;
//  Get image picker
pickImage() async{
  //  get image
final imagePicker=await ImagePicker().pickImage(source: ImageSource .gallery);
if (imagePicker!=null) {
  Get.snackbar("Profile Picture", "You have successfully selected your profile picture");
  _pickedImage =Rx<File?>(File(imagePicker.path));
 image=_pickedImage.value;
 update();
}
}




// ----------------------------- login ---------------------------
login({

  email, password
})async{
  isloadingLogin=true;
  update();
try {
  
  await  firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
  islogin.write('islogin', true);
  Get.offAll(const ScreenHome());

    return Get.snackbar("Login", "Login colmplt");
  }
  );
  
} catch (e) {
  Get.snackbar("Error", e.toString());
  
}

isloadingLogin=false;
  update();
}









}