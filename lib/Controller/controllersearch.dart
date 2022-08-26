import 'package:get/get.dart';

class ControllerSearch extends GetxController{
  List reslut=[];
search(List items,String _controller ,table){
               List _allUsers= [];
               if (_controller.isNotEmpty) {
            reslut=   items.where((element) => element[table].toLowerCase().contains(_controller)) .toList();}
            update();
}




}