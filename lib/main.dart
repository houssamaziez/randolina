import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:randolina/Controller/AuthonticationController.dart';
import 'package:randolina/ct.dart';
import 'View/Screens/screenStart/screenStart.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(ControllerAth());
//  await controllerUser.getData();
// Get.put(ReelsController());
// await firebaseAuth.signOut();
// islogin.write("islogin", false);
   runApp(const MyApp());
    await controllerUser.getData();
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenStart(),
    );
  }
}