import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:randolina/View/EmailSend/sendemail.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/profileClien/profileUser.dart';
import '../../../../../../Controller/eventController.dart';
import '../../../../../../const.dart';
class ScreenAcspt extends StatelessWidget {
var controllerivent= Get.put(IventsController());
    ScreenAcspt({Key? key,required this.name,
    required this.email,required this.uid,
    required this.photoprofile,required this.phone,
     required this.wilaya,required this.conferm,
     required this.idpost,required this.listlenghtconfimed,required this.nombresplaces}) : super(key: key);
final name , email , uid,photoprofile, phone, wilaya, conferm, idpost, listlenghtconfimed,nombresplaces;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBardALL(context, "Screen Acsept"),
      body:Column(children: [
const Spacer(),
        _card(),
const Spacer( flex: 2),
      ],));
  }
  _card(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
         Column(
            children: [
          const SizedBox(height: 40,),
              Card(   elevation: 17,
                // ignore: prefer_const_constructors
                 shape: shapecard() ,
                // ignore: sized_box_for_whitespace
              child: _info()
              ),
          const SizedBox(height: 17,),
            ],
          ),
         _imageprofile(),
 Positioned(bottom: 0,left: 0,right: 0,
           child: SizedBox(width: double.infinity,
           height: 50,
             child: Row(children: [
            const Spacer(),
              _conferm(),
            const Spacer(),
              _call(),
            const Spacer(),
            sendpdf(),
            const Spacer(),
             ],),
           ),
         ),
        ],
      ),
    );
  }

  Container sendpdf() {
    return Container(
                   decoration: const BoxDecoration(
                   color: Colors.white,
                   borderRadius:BorderRadius.only(
                   topLeft: Radius.circular(10),
                   topRight: Radius.circular(10),
                   bottomLeft: Radius.circular(10),
                   bottomRight: Radius.circular(10)
   ),), child:     bottun(title: "Send invitation", color: const Color.fromARGB(255, 243, 107, 33), function: (){
    Get.to(Screensend(name: name, email: email));
           }, 
           hiegth: 37.00, width: 100.00,  pad: true
           ) ,
            );
  }

  Container _call() {
    return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                    borderRadius:BorderRadius.only(
  
                 topLeft: Radius.circular(10),
  
                   topRight: Radius.circular(10),
  
                   bottomLeft: Radius.circular(10),
  
                   bottomRight: Radius.circular(10)
  
   ),), child:    bottun(width: 100.00,
    title: "Call", color: const Color.fromARGB(255, 33, 243, 33), function: (){
            launchCaller(phone);
           }, 
           hiegth: 37.00,  pad: true
           ) ,
            );
  }

  Container _conferm() {
    return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                    borderRadius:BorderRadius.only(
  
                 topLeft: Radius.circular(10),
  
                   topRight: Radius.circular(10),
  
                   bottomLeft: Radius.circular(10),
  
                   bottomRight: Radius.circular(10)
  
   ),), child:    bottun(width: 100.00,
    title:conferm!=true? "Conferm": 'Delete', color: Colors.blue, function: (){
            
               Get.defaultDialog(title: "Participate",
content:conferm==true? const Text('Do you want to Delete your participation in the trip?'):const Text('Do you want to confirm your participation in the trip?'),
cancel: TextButton(onPressed: (){
 Get.back();
 Get.back();


}, child: const Text("cancel")),
confirm: TextButton(onPressed: (){
 conferm? controllerivent.deletpart(uid, idpost): (
 listlenghtconfimed+1<=int.parse(nombresplaces)?

controllerivent.confermpart(uid, idpost) :
Get.snackbar('Completd', "List complte"))

;
 Get.back();
 Get.back();
 
}, child: const Text("confirm")));

           }, 
           hiegth: 37.00, pad: true
           ) ,
            );
  }
  Container _info() {
    return Container(height: 200,width: double.infinity,
            child: Column(
              children: [
        const SizedBox(height: 50,),
              Text(name, style:const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),), 
        const SizedBox(height: 10,),
              Text(email, style:const TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,), 
              Text(phone, style:const TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
               textAlign: TextAlign.start,),
              Text(wilaya, style:const TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
               textAlign: TextAlign.start,), 
            ],),
             );
  }

  Align _imageprofile() {
    return Align(alignment:Alignment.topCenter,
         child: Center(
           child: SizedBox(height: 90,width: 90,
                                 child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                  child: InkWell(
                                  borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                    onTap: (){
          Get.to(()=> SceenProflileAll(id: uid, imageprofile: photoprofile, name: name));
         },
                                    child: Container(
                                                   
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(decoration: BoxDecoration(boxShadow: [
                                               BoxShadow(
                                                 color: Colors.grey.withOpacity(0.8),
                                                 spreadRadius:4,
                                                 blurRadius: 5,
                                                 offset: const Offset(0, 5), // changes position of shadow
                                               ),
                                             ],),
                                          child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                                
                                            child: CachedNetworkImage(width: double.infinity,
                                                                                    fit: BoxFit.cover,
                                                                                    imageUrl:photoprofile.toString(),
                                                                                    placeholder: (context, url) => spinkit,
                                                                                    errorWidget: (context, url, error) =>
                                                                                        const Icon(Icons.error),
                                                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                                             ),
                               ),
         ),
       );
  }
}

RoundedRectangleBorder shapecard() {
    return const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
               Radius.circular( 30)
            ),);
  }