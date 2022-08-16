import 'package:get/state_manager.dart';

class StoreController extends GetxController {


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
}