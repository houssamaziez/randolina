import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:randolina/const.dart';

class StoreController extends GetxController {
  late int posistion=-1;
updt(ind){
posistion=ind;
update();
}

 bool issuperm= false;
 delletpost(){
if (issuperm== true) {
  issuperm= false;
  update();
}else{
  issuperm= true;
  update();
}
 }
 @override
  void onClose() {
   posistion=-1;
update();
    super.onClose();
  }
deleteproduct(id, context)async{
 Get.defaultDialog( title: "Delete", content: Text("Do you want to delete" , textAlign: TextAlign.center,
 ),
 confirm: TextButton(onPressed: ()async{
await firestor.collection("Store").doc(id).delete();
                 Navigator.pop(context);


 }, child: Text("Confirm"),)
,cancel: TextButton(onPressed: (){
  Get.back();
 }, child: Text('Cancel')));

posistion=-1;
update();
}

}