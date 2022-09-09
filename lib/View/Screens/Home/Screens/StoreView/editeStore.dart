import 'dart:io';
// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import '../../../../../Controller/controllerStor.dart';
import '../../../../../const.dart';
import '../../../Registre/widgets.dart';

 late DateTime datedubteiventt;
class EditeStore extends StatefulWidget {
  final _controller= Get.put(ControllerStor());
   final String detailsProduct,nameproduct,price ;
  final id ;
    EditeStore({Key? key,required this.id, required this.detailsProduct, required this.nameproduct, required this.price}) : super(key: key);
  @override
  State<EditeStore> createState() => _EditeStoreState();
}
class _EditeStoreState extends State<EditeStore> {
 
  _getimage()async{
             //  get image
final imagePicker=await ImagePicker().pickImage(source: ImageSource .gallery);
if (imagePicker!=null) {
  Get.snackbar("Profile Picture", "You have successfully selected your profile picture");
  CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePicker.path,maxHeight: 1000,
      aspectRatio:const CropAspectRatio(ratioX:12 , ratioY: 8) ,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: color1,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
 setState(() {
 imagepath=imagePicker.path;
 });
}
  }
  var nameproduct;
  var detailsProduct;
  var price;
// ignore: prefer_typing_uninitialized_variables
late String imagepath;
final _formKey = GlobalKey<FormState>();
@override
  void initState() {
 nameproduct= widget.nameproduct;
 detailsProduct= widget.detailsProduct;
 price= widget.price;
    super.initState();
  }
@override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  //APP BAR 
appBar  : appBardALL(context, "Edite"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
        children: [
         const SizedBox(height: 40,),
         suptitle(title: 'Name of product :\n $nameproduct'),
         const SizedBox(height: 20,),
         Form(
             key: _formKey,

           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               textchos(title: "Burger...", function: (val){setState(() {
                  nameproduct=val;
                });})  ,
               const SizedBox(height: 20,),
               suptitle(title: 'Price :\n $price Da'),
               textchos(   typekybord: TextInputType.number,title: "2000Da ", function: (val){setState(() {
                  price=val;
                });})  ,
               const SizedBox(height: 20,),
               suptitle(title: 'Description :\n $detailsProduct'),
               textchos(title: "Text....", linamx: 1000, lin: 5, function: (val){setState(() {
                  detailsProduct=val;
                });})  ,
             ],
           ),
         )  ,
       
        //   BUTTON ADD IVENT
         buttonivnt(function: () async {
          widget._controller.uploadImageindex(true);
        
          if ( nameproduct.isEmpty || detailsProduct.isEmpty   || price.isEmpty  ) {
            Get.snackbar("Form", "Make sure all fields are filled in");
            }else{
               widget.  _controller.idetstor(details: detailsProduct, idstor:  widget.id , name: nameproduct , price:price);
          widget._controller.uploadImageindex(false);
          Navigator.pop(context);
          
  }
         }) , 
          ],),
      ),
    );
  }
  Padding textchos({required title ,linamx= 100, lin =1,required function , typekybord}) {
    return Padding(
padding: const EdgeInsets.only(right: 10),
child:   Container(child: 
          textfield( onChanged: function ,  title:  title , lin:lin, linamx: linamx, typeKeyboard: typekybord,)
,),
);
  }



 
}

  Padding buttonivnt({required function}) {
    return Padding(
 padding:  const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: InkWell(onTap: function,
   child: Container(
   decoration: BoxDecoration(
 color: const Color.fromARGB(255, 0, 104, 189),
 borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10)
 ),
 boxShadow: [
    BoxShadow(
      color: Colors.blue.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 3), // changes position of shadow
    ),
 
 ],
 ),
 child:   Center(child: GetBuilder<ControllerStor>(
  init: ControllerStor(),
   builder: (control) {
     return control.islodeinImage==true?spinkit: const Text("Next",style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),);
   }
 ),),
 height: 50, 
   width: double.infinity,
   ),
 ),
 );
  }

  Padding suptitle({required title,}) {
    return   Padding(
padding:const EdgeInsets.all(8.0),
child:   Text(title, style:const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
);
  }