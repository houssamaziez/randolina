  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/eventController.dart';

import '../../editivent.dart';
import '../../widget.dart';

barcard(items, uid, controllivent) {
    return Expanded(child: Container(
child: Column(children: [ Text(items['username'], style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
Expanded(
  child:   Row(children: [
  
  bottun(title:uid==items['uid']?"Edit":(items['participate'].contains(uid)?"Annuler": 'Participate'), color:items['participate'].contains(uid)?Colors.red: Colors.blue , 
  
  
  
  function: (){
  
  uid==items['uid']?  Get.to(EditIvent(
  
      datedubteivent: items['time'],
  
      imagurl:items['urlImage'] ,
  
      details:items["details"]  , destination: items["destination"], price1:items["price"]  , distance:items["distance"]  , nombresplaces:items["nombresplaces"] , datedubte:items["datedubte"] , datefine:items["datefine"] , id:items["id"],   ))
  
  : Get.defaultDialog(title: "Participate",
  
  content: Text(items['participate'].contains(uid)?"Do you want to cancel your participation in the trip?":'Do you want to confirm your participation in the trip?'),
  
    cancel: TextButton(onPressed: (){
  
  Get.back();
  
  }, child: const Text("cancel")),
  
    confirm: TextButton(onPressed: (){
  
    final _controller= Get.put(IventsController());
    _controller.participer(idpost:items['id'], list:items  );
  
  Get.back();
  
  }, child: const Text("confirm")));
  
  }),
  
  Spacer(),
  
  IconButton(onPressed: (){
    final _controller= Get.put(IventsController());
    _controller.seveevent(idpost:items['id'], list:items  );
  }, icon: Icon(items['save'].contains(uid)?Icons.bookmark:Icons.bookmark_border, color: Colors.black,)) ],),
)
],),
));
  }
