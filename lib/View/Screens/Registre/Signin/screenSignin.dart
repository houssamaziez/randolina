import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/AuthonticationController.dart';
import 'package:randolina/const.dart';

import '../screenChos.dart';
import '../widgets.dart';

class ScreenSignIn extends StatefulWidget {
    ScreenSignIn({Key? key}) : super(key: key);

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  var cont=Get.put(ControllerAth());
  late String user="", password="";
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      floatingActionButton: GetBuilder<ControllerAth>(
        builder: (conttroller) {
          return FloatingActionButton(backgroundColor: color1,
            onPressed: (){
                  cont.login(email:user, password: password );

          }, 
          
          child:conttroller.isloadingLogin==true?spinkit: Icon(Icons.login),);
        }
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(height: MediaQuery.of(context).size.height*0.98,
            child: Column(
              children: [
                Spacer(),
                Hero(
                 tag: "appbarimage", 
                  child: Image.asset("images/appbarimage.png")),
               Padding(
                padding:  EdgeInsets.all(8.0),
                child:  textfield(
                  title: 'User name Or phone number....',
                  onChanged: (vl){
                setState(() {
                user=vl;
                  
                });            }
                ),
              ), Padding(
                padding:  EdgeInsets.all(8.0),
                child:  textfield(
                  title: 'Password....',
                  onChanged: (vl){ 
                setState(() {
                password=vl;
                });              }),
              ),
              Row(
                children: [
                  Spacer(),
                  TextButton(child: const Text("Forgot password ?"), onPressed: (){}),
                ],
              ),
  //  button( title: "Sign In", istrue: (password=="" ||  user==""),
  //           function: 
  //             cont.login(email:user, password: password ),
  //                ),
          
            const    Spacer(),
           const   Padding(
               padding:  EdgeInsets.only(right: 30, left: 30, bottom: 20),
               child:   Divider(
                    height: 1,
                    color: Colors.grey,
                    
                  ),
             ),
                const Text("Don’t have an account ?"),
                  TextButton(child: const Text("Creat an account Now "), onPressed: (){
                    Get.to(ScreenChos());
                  }),
            const    Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}