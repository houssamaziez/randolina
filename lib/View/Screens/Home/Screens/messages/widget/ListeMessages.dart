 import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/msgproduct.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/widget/userinfo.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../Controller/storController.dart';
import '../../../../../../const.dart';
import '../../StoreView/profileStore.dart';

GetBuilder<ControllerMessanger> listmessages(idm,idmsg) {
    return GetBuilder<ControllerMessanger>(
          init: ControllerMessanger(),
          builder: (cont) {
            if (cont.rsltdatamesage.length==1) {
                idm=cont.rsltdatamesage[0]["msgid"];
            }else{
              
              idm=idmsg;

 }
            return  StreamBuilder(
            stream: firestor.collection('Massenger').doc(idm.toString()).collection("messages").orderBy("time", descending: true).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var items = snapshot.data?.docs ?? [];
                return ListView.builder(reverse: true,
                       itemCount: items.length,

               shrinkWrap: true,
                 padding: const EdgeInsets.only(top: 10,bottom: 60),
              itemBuilder: (context, index){
  return Container(
    padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
    child: Align(
      alignment: (items[index]["uid"] != firebaseAuth.currentUser!.uid?Alignment.topLeft:Alignment.topRight),
      child:items[index]["message"]is List?_post(price:items[index]["message"][5],

       tag:index.toString(),detials: items[index]["message"][6],
                uid: items[index]["message"][2],username: items[index]["message"][1], urlimage: items[index]["message"][3], userphoto: items[index]["message"][0]
                 ): Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (items[index]["uid"]  != firebaseAuth.currentUser!.uid?Colors.grey.shade200:Colors.blue[200]),
                ),
                padding: const EdgeInsets.all(16),
                child:items[index]["message"]=="°°USERINFO°°"?newMethod(items[index]["uid"]  != firebaseAuth.currentUser!.uid,  items[index]["uid"] ) :Text(items[index]["message"], style: const TextStyle(fontSize: 15),),
      ),
    ),
  );
},
);
              }
            );
          }
        );
  }

  newMethod(isuser,   uid, ) => TextButton(onPressed: ()async{
var controllerMessanger= Get.put(ControllerMessanger());
var iteme=await controllerMessanger.getdatauser(uid);
    Get.to(ScreenInfoUser(name:iteme['name'] , email: iteme['email'], uid: uid, photoprofile: iteme['photoProfil'], phone: iteme['phone'], wilaya: iteme['wilaya']));
  }, child: Text("Personal information"));


  _post({userphoto,username, uid,urlimage, tag, price,required detials, nameproduct}) {
  return InkWell(
    onTap: (){
     Get.to(MessageProduct(pricee:price ,detials:detials ,
      image: urlimage, tag: tag,   iduser: uid, username: username, imageprofile: userphoto));
 
  
    },
    onLongPress: (){
 
  },

    child: GetBuilder<StoreController>(init: StoreController(),
      builder: (conte) {
    return 
      Stack(
          children: [
            Container(width: 150,height: 200,
              child: Card(
                child:         Stack(
                  children: [
                    Container(height: double.infinity,width: double.infinity,
                                          child: ClipRRect(
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(5),),
                                                      child:Hero(tag: urlimage.toString(),
                                                        child: CachedNetworkImage(
                                                          height: double.infinity,
                                                          width: double.infinity,
                                                                                        fit: BoxFit.cover,
                                                                                        imageUrl: urlimage.toString(),
                                                                                        placeholder: (context, url) => spinkit,
                                                                                        errorWidget: (context, url, error) =>
                                                                                            const Icon(Icons.error),
                                                                                      ),
                                                      ),
                      ),),
             
             Align(alignment: Alignment.bottomCenter,
                    child: Container(width: double.infinity,
                          height: 50,
                          color: Colors.white.withOpacity(0.5),
                          child: Center(child: Text("${price} DA",
                           style:const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black),),),),
                  ) ],
                ),
               ),
            ),
          ],
        );
      }
    ),
  );
  ;
}
