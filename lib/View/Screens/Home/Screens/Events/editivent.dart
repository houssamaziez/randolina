import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:randolina/Controller/iventController.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/addIvent.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import 'package:randolina/View/Widgets/time.dart';

import '../../../../../ct.dart';
import '../../../Registre/widgets.dart';

class EditIvent extends StatefulWidget {

  final  imagurl, details,datedubteivent,destination,price1 ,distance, nombresplaces,
   datedubte, datefine, id;
  var _controller= Get.put(IventsController());
  
    EditIvent({Key? key, required this.details, required this.destination, required this.price1, required this.distance, required this.nombresplaces, required this.datedubte, required this.datefine,required this.id,required this.imagurl,required this.datedubteivent}) : super(key: key);

     
  @override
  State<EditIvent> createState() => _EditIventState();
}
class _EditIventState extends State<EditIvent> {
  _getimage()async{
             //  get image
final imagePicker=await ImagePicker().pickImage(source: ImageSource .gallery);
if (imagePicker!=null) {
  Get.snackbar("Profile Picture", "You have successfully selected your profile picture");
  _pickedImage =File(imagePicker.path) ;
 setState(() {
 image=_pickedImage;
 imagepath=imagePicker.path;
   
 });
}
  }
// ignore: prefer_typing_uninitialized_variables
var _pickedImage;
File? get profilePhoto =>  _pickedImage.value;
// ignore: prefer_typing_uninitialized_variables
var image;
late String imagepath;

final _formKey = GlobalKey<FormState>();

@override
  void dispose() {
   image=null;
    super.dispose();
  }
   var _details,_datedubteivent,_destination,_price ,_distance , _nombresplaces,
   _datedubte,    _datefine ;
@override
  void initState() {
    _details=widget.details;
    _datedubteivent=widget.datedubteivent;
    _destination=widget. destination;
    _price=widget. price1;
    _distance=widget. distance;
    _nombresplaces= widget. nombresplaces;
    _datedubte=widget. datedubte;
    _datefine=widget. datefine;
    // TODO: implement initState
    super.initState();
         
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  //  APP BAR 
appBar: appbarev(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
        children: [
         const SizedBox(height: 40,),
        //  const  Center(child: Text("principal picture of event" , style: TextStyle(color: Colors.black54,fontSize: 20, fontWeight: FontWeight.bold),)),
          // add image profile ivent 
          // addimage(functon: _getimage),
          // image view
          image==null? Container():  Container(height: 200,
             width: double.infinity,
               child:   Image.file(
                    image,fit: BoxFit.contain,)
             ),
        //   DETAILS OF IVENTS
         const SizedBox(height: 20,),
         suptitle(title: 'Destination :\n ${widget.destination}'),
         const SizedBox(height: 20,),
         Form(
             key: _formKey,
           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               textchos(title: _destination, function: (val){setState(() {
                  _destination=val;
                });})  ,
               const SizedBox(height: 20,),
               suptitle(title: 'Price :\n ${widget.price1}'),
               textchos(   typekybord: TextInputType.number,title: _price, function: (val){setState(() {
                  _price=val;
                });})  ,
               const SizedBox(height: 20,),
               suptitle(title: 'Description :${widget. details}'),
               textchos(title: _details, linamx: 1000, lin: 5, function: (val){setState(() {
                  _details=val;
                });})  ,
            
               const SizedBox(height: 20,),
               suptitle(title: 'Distance de marche :\n ${widget.distance}'),
               const SizedBox(height: 20,),
               textchos(
                typekybord: TextInputType.number,
                title: _distance,function: (val){setState(() {
                _distance=val;
                });}),
                  const SizedBox(height: 20,),
         suptitle(title: 'Nombres des places :\n ${widget.nombresplaces}'),
         const SizedBox(height: 20,),
         textchos(   typekybord: TextInputType.number,title: _nombresplaces, function: (val){setState(() {
            _nombresplaces=val;
          });}),
             ],
           ),
         )  ,
        //   BUTTON ADD IVENT
         buttonivnt(
          
                      title: "Edit ",
          
          function: (){
           widget.  _controller.editivent(
                idivnt:widget.id , 
                
              destination: _destination, details:_details, distance: _distance, nombresplaces:_nombresplaces, price: _price,   );
         }) , 
            const SizedBox(height: 20,),
               suptitle(title: 'Date de l’évenement :'),
               const SizedBox(height: 20,),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Départ :\n ${widget.datedubte}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                 ), 
             
          BasicDateTimeField(type: "Départ"),
               const SizedBox(height: 20,), 
                 Padding(
               padding: EdgeInsets.all(8.0),
               child: Text('Retour :\n ${widget.datefine}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
               ), 
               BasicDateTimeField(type: "Retour"),
                     buttonivnt(
                      title: "Edit date",
                      function: (){
           widget.  _controller.editiventdate(datedubteivent: datedubteiventt!=null?datedubteiventt:_datedubteivent,
                idivnt:widget.id , 
                 datedubte:datedubte.isNotEmpty?datedubte: _datedubte, 
              datefine:  datefine.isNotEmpty?datefine: _datefine , destination: _destination, details:_details, distance: _distance, nombresplaces:_nombresplaces, price: _price,   );
         }) ,  ],),
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

  Padding buttonivnt({required function,required title}) {
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
 height: 50, 
   width: double.infinity,
 child:   Center(child: GetBuilder<IventsController>(
  init: IventsController(),
   builder: (control) {
     return control.editdate==true?spinkit:   Text(title,style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),);
   }
 ),),
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