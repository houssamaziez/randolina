import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/messages/screenAllMessage.dart';

import '../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../const.dart';

class ScreenCHat extends StatefulWidget {
  final idclien , idmsg, imageprofile, name;
    ScreenCHat({Key? key,required this.idclien,required this.idmsg,required this.imageprofile,required this.name}) : super(key: key);

  @override
  State<ScreenCHat> createState() => _ScreenCHatState();
}

class _ScreenCHatState extends State<ScreenCHat> {
var controllerMessanger= Get.put(ControllerMessanger());

TextEditingController _controllertext=TextEditingController();
@override
  void initState() {
   if (widget. idmsg=="0") {
     
   }
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

     appBar: AppBar(actions: [IconButton(onPressed: (){},
      icon: Icon(Icons.call, color: Colors.black,)), SizedBox(width: 10,)],
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
      title:Row(
        children: [
          SizedBox(height: 35,width: 35,
                          child:ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(1000)),
                            child: CachedNetworkImage(width: double.infinity,
                                                                    fit: BoxFit.cover,
                                                                    imageUrl:widget.imageprofile.toString(),
                                                                    placeholder: (context, url) => spinkit,
                                                                    errorWidget: (context, url, error) =>
                                                                        const Icon(Icons.error),
                                                                  ),
                          ),
                        ),
        SizedBox(width: 10,),  Expanded(child: Text(widget.name, style: TextStyle(color: Colors.black),)),
        ],
      ),
        shape:const RoundedRectangleBorder(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),) ,
        backgroundColor: Colors.white,
    ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
          stream: firestor.collection('Massenger').doc(widget.idmsg).collection("messages").orderBy("time", descending: true).snapshots(),
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
        child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (items[index]["uid"]  != firebaseAuth.currentUser!.uid?Colors.grey.shade200:Colors.blue[200]),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(items[index]["message"], style: const TextStyle(fontSize: 15),),
        ),
      ),
    );
  },
);
            }
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                    Expanded(
                    child:  TextField(controller: _controllertext,
                      decoration:const  InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      if (_controllertext.text.isNotEmpty) {

controllerMessanger.sendmessageToAll(users: widget.idclien, msg: _controllertext.text, idmsg: widget.idmsg);
              _controllertext.clear();
              }
                    },
                    child: const Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
                
              ),
            ),
          ),
        ],
      ),
      
 
    );
  }
}


 