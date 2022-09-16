
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/eventController.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/Admine/screenAcspt.dart';
 
import 'package:randolina/View/Screens/Home/Screens/Events/editivent.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import 'package:randolina/const.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../Controller/controllerUser.dart';
import '../../../../../EmailSend/sendemail.dart';

class ProfileEvent extends StatefulWidget {
    ProfileEvent({Key? key,required this.image,required this.tag,required this.list}) : super(key: key);
final     list;
final String image, tag;

  @override
  State<ProfileEvent> createState() => _ProfileEventState();
}

class _ProfileEventState extends State<ProfileEvent> {
var listlenghtunconfimed =0;
 int initial = 0;
  late int posistion=-1;
var listlenghtconfimed =0;

var controllerivent= Get.put(IventsController());
@override
  void initState() {
  // listlenghtconfimed=  widget. list['confermnum'].length;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBardALL(context, "Participant List"),
  backgroundColor: Colors.white,
       body: ListView(children: [
        SizedBox(height: 10,), 
         Cardevent(widget. list,widget. tag),

 
 const SizedBox(height: 20,),
 Center(
            child: GetBuilder<UserController>(
        init: UserController(),
              builder: (cont) {
                return CustomSlidingSegmentedControl<int>(
                  initialValue: initial,
                  height: 24,
                  children:   {
                    0:   Text('           All           '),
                    1:   Text('liste confirmé'),

                  } ,
                  decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        offset: const Offset(
                          0.0,
                          2.0,
                        ),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  onValueChanged: (v) {
                    setState(() {
                      initial = v;
                    });
                  },
                );
              }
            ),
          ),
  
       initial==0? listparti(false, ): listparti(true),
       
       
const SizedBox(height: 10,),  
  Padding(
 padding:  const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: InkWell(onTap: (){

  Get.to(EditIvent(
    datedubteivent: widget.list['time'],
    imagurl:widget.list['urlImage'] ,
    details:widget.list["details"]  , destination: widget.list["destination"], price1:widget.list["price"]  , distance:widget.list["distance"]  , nombresplaces:widget.list["nombresplaces"] , datedubte:widget.list["datedubte"] , datefine:widget.list["datefine"] , id:widget.list["id"],   ));
 },
   child: Container(
   decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius:const BorderRadius.only(
      topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
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
 child:   const Center(child: const Text("Edit",style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),),),
    height: 50, 
   width: double.infinity,
   ),
 ),
 )
,     ],),
    );
  }

 bool _issee=false;

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> listparti(
isconferm
  ) {

    return StreamBuilder(
          stream:isconferm==true?  firestor.collection('Ivent').doc( widget.list["id"]) .collection('participate').where("conferm",isEqualTo: isconferm).snapshots(): firestor.collection('Ivent').doc( widget.list["id"]) .collection('participate').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            List items = snapshot.data?.docs ?? [];
            listlenghtconfimed=items.length;
      if (snapshot.connectionState == ConnectionState.waiting) {
         return const Padding(
        padding:  EdgeInsets.all(100.0),
        child: spinkit,
      );
    } else if (snapshot.connectionState == ConnectionState.active
        || snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        return 
         Column(
           children: [
            
Row(
    children: [
     Spacer(),
     Padding(
       padding:  EdgeInsets.all(12.0),
       
       child: Text(
       listlenghtconfimed.toString()+"/"+widget.list["nombresplaces"],
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500 , color: Colors.grey
        ),),

 ),
 
    ],
  ),

             ListView.builder(
 physics:const NeverScrollableScrollPhysics(),
shrinkWrap: true,
itemCount:items.length,
itemBuilder: 
 ( context, indext) {
  print(items.isEmpty);

  isconferm==true?listlenghtconfimed=items.length: listlenghtunconfimed =items.length;

  return   items.isEmpty?Text("List is empty", style: TextStyle(color: Colors.black),): 
   newMethod(indext,items, context, widget.list["id"], isconferm);
}
),
           ],
         );
} else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
 }
             );
  }

    newMethod(int indext, list,context, id, isconferm) {
    return Container(
      width: heightphon(context),
      height: 93,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(onTap: ()
              {

Get.to(ScreenAcspt(idpost: id,token: "" ,
listlenghtconfimed: listlenghtconfimed,
nombresplaces: widget.list["nombresplaces"],
  email: list[indext]['email'],wilaya: list[indext]['wilaya'] ,  name: list[indext]['username'],phone: list[indext]['phone'], photoprofile: list[indext]['photoProfil'].toString(), uid: list[indext]['uid'], conferm: list[indext]['conferm'], ));



           },

                child: Card(
                   color:   Color.fromARGB(255, 255, 255, 255),
                  elevation: 4,
                  child: ListTile(
                  trailing:IconButton(onPressed: ()async{
var _controllerUser=Get.put(ControllerMessanger());
 var _data= await  _controllerUser.getdatauser(list[indext]['uid']);
 if (_data!=null) {
// Get.to( Screensend(email:list[indext]['email'],name: list[indext]['username'],));
      launchCaller(_data["phone"].toString());
   return;
 }
                  },
                    icon: const Icon(Icons.phone, color: Colors.blue,)),
                  subtitle:  Text(list[indext]['phone'],  style:const TextStyle( color: Colors.blue)),
                  leading:CircleAvatar(backgroundColor: Colors.grey,
                    radius: 24,
                    backgroundImage: NetworkImage(list[indext]['photoProfil'].toString()),),
                  title:Text(list[indext]['username']) ,),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          IconButton(onPressed: (){}, icon: Stack(
            children: [
              Center(
                child: Image.asset( list[indext]['conferm']==true?
                  
                  "images/classment 1.jpg":"images/classment .jpg", height: 100,width: 200, fit: BoxFit.cover,),
              ),
              Center(child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text("${indext+1}", style:const TextStyle(fontWeight:FontWeight.bold, color: Colors.blue) ,),
              ))
            ],
          ))
        ],
      ),
    );
  }
}

  Padding Cardevent(list,tag ) {
    return Padding(
         padding: const EdgeInsets.all(8.0),
         child: Card(color:  Colors.white,
          
          shape:  RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(15.0),
),
                                 
                                  child: Stack(
                                    children: [
                                      Container(height: 200,width: double.infinity,
                                      child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(15),),
                                                  child:Hero(tag:  tag.toString(),
                                                    child: CachedNetworkImage(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                                                    fit: BoxFit.cover,
                                                                                    imageUrl:   list['urlImage'].toString(),
                                                                                    placeholder: (context, url) => spinkit,
                                                                                    errorWidget: (context, url, error) =>
                                                                                        const Icon(Icons.error),
                                                                                  ),
                                                  ),
                                          ),),
                                           Positioned(right: 0,bottom: 0,left: 0,
                                             child: Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Align(alignment: Alignment.bottomCenter,
                                                   child:    Container(child:Stack(
  children: <Widget>[
    // Stroked text as border.
    Text(
     list['destination'],
      style: TextStyle(
        fontSize: 35,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..color = Color.fromARGB(255, 0, 0, 0),
      ),
    ),
    // Solid text as fill.
    Text(
     list['destination'],
      style: const TextStyle(
        fontSize: 35,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    ),
  ],
)
                     
                     
                       ),
                                             ),
                                           ),
                                           ),
                                       
                                       Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Align(alignment: Alignment.topLeft,
                                      child:   Container(
                                        child: Center(child: Text(" "+   list['datedubte'], 
                                        maxLines: 1,  overflow: TextOverflow.fade,textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold, color: Colors.black54),),),
                                        decoration: BoxDecoration(
                                          
                                          borderRadius: BorderRadius.all(Radius.circular(70)),
                                          color: Colors.white.withOpacity(0.44),),
                                        height: 50,width: 68,)
                                ),
                                         ),
                                       Positioned(right: 0,top: 0,
                                      child:  RotatedBox(
                                              quarterTurns: 4,
                                        child: Image.asset("images/Rectangle.png",)),
                                    ),
                                 Positioned(right: -3,top: 20,
                                      child:    Transform(
                                      // ignore: sort_child_properties_last
                                      child:  Padding(
                                        padding:  EdgeInsets.all(8.0),
                                        child:  Text(
                                        list['price']+"DA",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      alignment: FractionalOffset.center,
                                      transform: new Matrix4.identity()
                                        ..rotateZ(0.88),
                                    ),
                                ),
                                    ],
                                  ),),
       );
  }
   