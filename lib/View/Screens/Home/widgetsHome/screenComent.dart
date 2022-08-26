// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:randolina/View/Screens/Registre/widgets.dart';
import '../../../../Controller/controllerLiksComnt.dart';
import '../../../../const.dart';

// ignore: must_be_immutable
class ScreenComent extends StatelessWidget {
   ScreenComent({Key? key,required this.id,required this.doc }) : super(key: key);
var controllerlikcomnt=Get.put(ControllerLikCont());
TextEditingController controllertexfild=TextEditingController();
final id , doc;
late String commenter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
floatingActionButton: Row(children: [Expanded(child:Padding(
  padding: const EdgeInsets.only(left: 40),
  child:   textfield(title: "Commenter ...",controller:  controllertexfild),
) ) , IconButton(onPressed: (){
  if (controllertexfild.text.isNotEmpty) {
                                  controllerlikcomnt.postComment(idpost: id, textcomment: controllertexfild.text, docs:doc );
                                  controllertexfild.clear();
    
  }

}, icon: Icon(Icons.send, color: Colors.white,))],),

      backgroundColor: Color.fromARGB(255, 15, 15, 15),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Commentaires"),
        backgroundColor: Colors.black,),
      body:    StreamBuilder(
            stream: firestor.collection(doc).doc(id).collection("comment").orderBy("time", descending: false).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var items = snapshot.data?.docs ?? [];
             
       if (snapshot.connectionState == ConnectionState.waiting) {
        return   const Padding(
          padding: const EdgeInsets.all(100.0),
          child: spinkit,
        );
      } else if (snapshot.connectionState == ConnectionState.active
          || snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount:items. length,
            itemBuilder: (context, indext){
               final Timestamp timestamp = items[ indext]['time'] as Timestamp;
      final DateTime dateTime = timestamp.toDate();
      final dateString = DateFormat('MMM d, h:mm a').format(dateTime);
            return InkWell(onLongPress: (){
           items[ indext]['uid']==firebaseAuth.currentUser!.uid?    controllerlikcomnt.settingcmnet(id: items[ indext]['id'],idpost: id): (){};
            },
              child: ListTile(title:Text(items[indext]["username"], style: TextStyle(color: Colors.white),)  ,
              leading:  SizedBox(height: 50,width: 50,
                child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(1000)
                              ),
                              child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:items[indext]["profilephoto"],
                    placeholder: (context, url) => spinkit,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              
              subtitle: Text(items[indext]["comment"] , style: TextStyle(color: Colors.grey),) ,trailing: Text(dateString, style: TextStyle(color: Colors.white),) ,
              ),
            );
          });
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }
      
      
      
      
      
       }
               ),


    );
  }
}