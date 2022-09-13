  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/profileUser.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../const.dart';

AppBar appbarmessage(BuildContext context, name, imageprofile,idcl ) {
    return AppBar(actions: [IconButton(onPressed: ()async{
var _controllerUser=Get.put(ControllerMessanger());
 var _data= await  _controllerUser.getdatauser(idcl);
 if (_data!=null) {
      launchCaller(_data["phone"].toString());
   return;
 }
    },
    icon: Icon(Icons.call, color: Colors.black,)), SizedBox(width: 10,)],
    leading: IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
    title:InkWell(onTap: () => 
    Get.to(SceenProflileAll(id: idcl, imageprofile: imageprofile, name: name)),
      child: Row(
        children: [
          SizedBox(height: 35,width: 35,
                          child:ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(1000)),
                            child: CachedNetworkImage(width: double.infinity,
                                                                    fit: BoxFit.cover,
                                                                    imageUrl:imageprofile.toString(),
                                                                    placeholder: (context, url) => spinkit,
                                                                    errorWidget: (context, url, error) =>
                                                                        const Icon(Icons.error),
                                                                  ),
                          ),
                        ),
        SizedBox(width: 10,), 
         Expanded(child: Text(name, style: TextStyle(color: Colors.black),)),
        ],
      ),
    ),
      shape:const RoundedRectangleBorder(
    borderRadius: const BorderRadius.vertical(
      bottom: Radius.circular(30),
    ),) ,
      backgroundColor: Colors.white,
  );
  }
