 import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/controllersearch.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/Admine/ProfileIventAddmin.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/widget.dart';
import 'package:randolina/View/Screens/Home/Screens/StoreView/profileStore.dart';

import '../../../../../Controller/eventController.dart';
import '../../../../../const.dart';
import '../Events/ProfileEvntUser.dart';
import '../Events/editivent.dart';


class ScreenSearchStors extends StatefulWidget {
  final tablename,docss;
   const ScreenSearchStors({Key? key,required this.tablename,required this.docss}) : super(key: key);
  @override
  State<ScreenSearchStors> createState() => _ScreenSearchStorsState();
}
class _ScreenSearchStorsState extends State<ScreenSearchStors> {
final _controller=TextEditingController();
var controllersearch= Get.put(ControllerSearch());
  IventsController controllivent= Get.put(IventsController());

String _textsearch="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      actions: [IconButton(onPressed: (){
        _controller.clear();
      }, icon: const Icon(Icons.cancel_outlined, color: Colors.black,),)],
        leading: IconButton(onPressed: (){
        Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back, color: Colors.black,),),
        title: TextField(
           autofocus: true,
          decoration: const InputDecoration(
        ),
        controller:_controller ,
        onChanged: (v){setState(() {
          _textsearch=v;
        });},
      ),backgroundColor: Colors.white,),
body: listserach(stream: firestor.collection("Store"), tablename: widget. tablename ));
  }
  
  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> listserach({required stream, required tablename}) {
     return StreamBuilder(
            stream: stream.snapshots(),
                        builder:  (context, AsyncSnapshot<QuerySnapshot> snapshot){
              var items = snapshot.data?.docs ?? [];
print(items);
if (snapshot.connectionState == ConnectionState.waiting) {
        return     Padding(
          padding:   EdgeInsets.only(top: heightphon(context, size: 0.4)),
          child: spinkit,
        );
      } else if (snapshot.connectionState == ConnectionState.active
          || snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
             controllersearch.search(items, _textsearch, "name");
          return        GetBuilder<ControllerSearch>(
            init: ControllerSearch(),
            builder: (cont) {
              // ignore: unnecessary_null_comparison
                 return Container(height: double.infinity,
                   child: ListView.builder(
                    itemCount:cont.reslut.length ,
                    shrinkWrap: true,
                    itemBuilder: 
                   (contex, index){
                    return  _card(cont.reslut, index);
                   }
                   ),
                 );
 
            }
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

  InkWell _card( items, index) {
    return InkWell(
  onTap: (){
    Get.to(ProfileProduct(token: "" ,
          imageprofile: items[index]["userphoto"].toString(),
        username:items[index]["username"].toString(),
            iduser: items[index]["uid"].toString(),

      image: items[index]["urlimage"].toString(), tag: items , list: items[index]));
  },
  onLongPress: (){

// controllerstor.delletpost();
setState(() {
// posistion=index;
 });
},

  child: SizedBox(height: 200,width: 300,
    child: Stack(
      children: [
        Card(
          child:         Stack(
            children: [
              Container(height: double.infinity,width: double.infinity,
                                    child: ClipRRect(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(5),),
                                                child:Hero(tag: items[index]["urlimage"].toString(),
                                                  child: CachedNetworkImage(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                                                  fit: BoxFit.cover,
                                                                                  imageUrl:items[index]["urlimage"].toString(),
                                                                                  placeholder: (context, url) => spinkit,
                                                                                  errorWidget: (context, url, error) =>
                                                                                      const Icon(Icons.error),
                                                                                ),
                                                ),
                ),),
  Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(radius: 25,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(height: 50,width: 50,
          
                     child:  ClipRRect(
          
                                                          borderRadius: const BorderRadius.all(
          
                                                            Radius.circular(1000),),
          
                                                          child:Hero(tag: index.toString(),
          
                                                            child: CachedNetworkImage(
          
                                                              height: double.infinity,
          
                                                              width: double.infinity,
          
                                                                                            fit: BoxFit.cover,
          
                                                                                            imageUrl:items[index]["urlimage"].toString(),
          
                                                                                            placeholder: (context, url) => spinkit,
          
                                                                                            errorWidget: (context, url, error) =>
          
                                                                                                const Icon(Icons.error),
          
                                                                                          ),
          
                                                          ),
          
                          ), ),
        ),
      ),
  SizedBox(width: 8,), Text(items[index]["username"].toString(), style: TextStyle(color: Colors.white,),) ],
  ),
  ), 
            Align(alignment: Alignment.bottomCenter,
              child: Container(width: double.infinity,
                    height: 50,
                    color: Colors.white.withOpacity(0.5),
                    child: Center(child: Text("${items[index]["price"]} DA",
                     style:const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black),),),),
            ) ],
          ),
   ),
    ],
    ),
  ),
);
  }
  Padding cardivent(List<QueryDocumentSnapshot<Object?>> items, int index, BuildContext context, controllivent) {
      return Padding(
padding: const EdgeInsets.all(8.0),
child:   InkWell(onTap: (){

  Get.to( ()=>firebaseAuth.currentUser!.uid!=items[index]['uid']? ProfileEventUser(image: items[index]['urlImage'], tag: index.toString(), list:  items[index]): ProfileEvent(image: items[index]['urlImage'], tag: index.toString(), list:  items[index]));
},
  child: Card(elevation: 16,
    child: Stack(
      children: [
        Container(
          width: widthphon(context),
        height: 300,
        decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5))
        
        ),
        child: Column(children: [const SizedBox(height: 10,), 
  barcard(items[index], controllivent),const SizedBox(height: 10,), 
          Expanded(
            flex: 3,
            child: ClipRRect(
          
                                    borderRadius: const BorderRadius.only(
          
                                        bottomLeft: Radius.circular(5),
          
                                        bottomRight: Radius.circular(5)),
          
                                    child:Stack(
                                      children: [
                                        Hero(
                                          tag: index.toString(),
                                          child: CachedNetworkImage(width: double.infinity,
                                                                      fit: BoxFit.cover,
                                                                      imageUrl:items[index]['urlImage'].toString(),
                                                                      placeholder: (context, url) => spinkit,
                                                                      errorWidget: (context, url, error) =>
                                                                          const Icon(Icons.error),
                                                                    ),
                                        ),
                                 
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Align(alignment: Alignment.bottomCenter,
        child:   Container(child: Text(items[index]['destination'], style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),)),
  ),
                                   ),            Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Align(alignment: Alignment.topLeft,
        child:   Container(
          child: Center(child: Text(" "+items[index]['datedubte'], 
          overflow: TextOverflow.fade,textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold, color: Colors.black54),),),
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white.withOpacity(0.6),),
  
          
          height: 50,width: 100,)
  ),
                                   ),
           ],
                                    ),
                                    
                                    
                                    
                                
          )),
        ],),
        
        ),
         Positioned(
      top: 55,left: 0, 
      right: 0,
      child: Center(
        child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(1000),),
                                    child:CircleAvatar(radius: 40,backgroundColor: Colors.grey,
                                      child: Container(height: 90,width: 90,
                                        child: CachedNetworkImage(width: double.infinity,
                                                                    fit: BoxFit.cover,
                                                                    imageUrl:items[index]['photouser'].toString(),
                                                                    placeholder: (context, url) => spinkit,
                                                                    errorWidget: (context, url, error) =>
                                                                        const Icon(Icons.error),
                                                                  ),
                                      ),
           ),
        ),
      )
      ) , 
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
             items [index]['price']+"DA",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        alignment: FractionalOffset.center,
        transform: new Matrix4.identity()
          ..rotateZ(0.88),
      ),
  ),
     ],
    ),
  ),
),
);
    }
     barcard(items, controllivent, ) {
    return Expanded(child: Container(
child: Column(children: [ Text(items['username'], style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),const Spacer(),
Row(children: [
bottun(title:firebaseAuth.currentUser!.uid==items['uid']?"Edit":(items['participate'].contains(firebaseAuth.currentUser!.uid)?"Annuler": 'Participate'), color:items['participate'].contains(firebaseAuth.currentUser!.uid)?Colors.red: Colors.blue , 

function: (){
firebaseAuth.currentUser!.uid==items['uid']?  Get.to(EditIvent(
    datedubteivent: items['time'],
    imagurl:items['urlImage'] ,
    details:items["details"]  , destination: items["destination"], price1:items["price"]  , distance:items["distance"]  , nombresplaces:items["nombresplaces"] , datedubte:items["datedubte"] , datefine:items["datefine"] , id:items["id"],   ))
: Get.defaultDialog(title: "Participate",
content: Text(items['participate'].contains(firebaseAuth.currentUser!.uid)?"Do you want to cancel your participation in the trip?":'Do you want to confirm your participation in the trip?'),
  cancel: TextButton(onPressed: (){
Get.back();
}, child: const Text("cancel")),
  confirm: TextButton(onPressed: (){
  controllivent.participer(idpost:items['id'], list:items  );
Get.back();
}, child: const Text("confirm")));
}),
 ],)
],),
));
  }

}

