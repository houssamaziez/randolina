import 'dart:io';
// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:randolina/Controller/eventController.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import 'package:randolina/View/Widgets/time.dart';
import '../../../../../const.dart';
import '../../../Registre/widgets.dart';
 String details="",destination="",price=""  ,distance="", nombresplaces="";
  String datedubte="" , datefine="";
 late DateTime datedubteiventt;
class AddIvent extends StatefulWidget {
  final _controller= Get.put(IventsController());
    AddIvent({Key? key}) : super(key: key);
  @override
  State<AddIvent> createState() => _AddIventState();
}
class _AddIventState extends State<AddIvent> {
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
  _pickedImage =File(croppedFile!.path) ;
 setState(() {
 image=_pickedImage;
 imagepath=imagePicker.path;
 });
}
  }
// ignore: prefer_typing_uninitialized_variables
var _pickedImage;
File? get profilePhoto =>  _pickedImage.value;
var image;
late String imagepath;
final _formKey = GlobalKey<FormState>();
@override
  void dispose() {
   image=null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  //APP BAR 
appBar  : appbarev(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
        children: [
         const SizedBox(height: 40,),
         const  Center(child: Text("principal picture of event" , style: TextStyle(color: Colors.black54,fontSize: 20, fontWeight: FontWeight.bold),)),
          // add image profile ivent 
          addimage(functon: _getimage),
          // image view
          image==null? Container():  Container(height: 200,
             width: double.infinity,
               child:   Image.file(
                    image,fit: BoxFit.contain,)
             ),
        //   DETAILS OF IVENTS
         const SizedBox(height: 20,),
         suptitle(title: 'Destination :'),
         const SizedBox(height: 20,),
         Form(
             key: _formKey,

           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               textchos(title: "alger ...", function: (val){setState(() {
                  destination=val;
                });})  ,
               const SizedBox(height: 20,),
               suptitle(title: 'Price :'),
               textchos(   typekybord: TextInputType.number,title: "club (13000Da max)", function: (val){setState(() {
                  price=val;
                });})  ,
               const SizedBox(height: 20,),
               suptitle(title: 'Description :'),
               textchos(title: "Text....", linamx: 1000, lin: 5, function: (val){setState(() {
                  details=val;
                });})  ,
               const SizedBox(height: 20,),
               suptitle(title: 'Date de l’évenement :'),
               const SizedBox(height: 20,),
               const  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Départ :', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                 ), 
               BasicDateTimeField(type: "Départ"),
               const SizedBox(height: 20,), 
               const Padding(
               padding: EdgeInsets.all(8.0),
               child: Text('Retour :', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
               ), 
               BasicDateTimeField(type: "Retour"),
                 
               const SizedBox(height: 20,),
               suptitle(title: 'Distance de marche :'),
               const SizedBox(height: 20,),
               textchos(
                typekybord: TextInputType.number,
                title: "exmpl: 80Km......",function: (val){setState(() {
                distance=val;
                });}),
                  const SizedBox(height: 20,),
         suptitle(title: 'Nombres des places :'),
         const SizedBox(height: 20,),
         textchos(   typekybord: TextInputType.number,title: "exmpl: 30,45,60......", function: (val){setState(() {
            nombresplaces=val;
          });}),
             ],
           ),
         )  ,
       
        //   BUTTON ADD IVENT
         buttonivnt(function: () async {
        
          if (image==null || destination.isEmpty || details.isEmpty || distance.isEmpty || nombresplaces.isEmpty || price.isEmpty || datedubte.isEmpty || datefine.isEmpty) {
            Get.snackbar("Form", "Make sure all fields are filled in");
            }else{

         uploadVideo( videoFile) async{
          widget._controller.uploadImageindex(true);
  var data;
    var uri = Uri.parse(urlserverfile);
    var request = new MultipartRequest("POST", uri);
    var multipartFile = await http. MultipartFile.fromPath("files", videoFile);
    request.files.add(multipartFile);
    StreamedResponse response = await request.send();
  response.stream.transform(utf8.decoder).listen((value) {
               widget.  _controller.uploadImage(
                datedubteivent: datedubteiventt,
                imagepath: image, datedubte:datedubte, 
              datefine: datefine, destination: destination, details:details, distance: distance, nombresplaces:nombresplaces, price: price, Imageurl: value,   );
         widget._controller.uploadImageindex(false);
Navigator.pop(context);

    });
 

    if(response.statusCode==200){
      print("Video uploaded");
    }else{
      print("Video upload failed");

      return data;

    }
  }
              var c=await uploadVideo( imagepath);   
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
 child:   Center(child: GetBuilder<IventsController>(
  init: IventsController(),
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