 
    import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ScreenHome/card/cardivbar.dart';

import '../../../../../../../const.dart';
import '../../../Profile/profileClien/profileUser.dart';
import '../../Admine/ProfileIventAddmin.dart';
import '../../ProfileEvntUser.dart';

Padding cardivent(List<QueryDocumentSnapshot<Object?>> items, int index, BuildContext context, uid,controllivent) {
      return Padding(
padding: const EdgeInsets.all(8.0),
child:   InkWell(onTap: (){

  Get.to( ()=>uid!=items[index]['uid']? ProfileEventUser(image: items[index]['urlImage'], tag: index.toString(), list:  items[index]): ProfileEvent(image: items[index]['urlImage'], tag: index.toString(), list:  items[index]));
},
  child: Card( 
    elevation: 16,
       shape: RoundedRectangleBorder(
    borderRadius: const BorderRadius.all(
       Radius.circular( 30)
    ),) ,
  child: Container( 
        height: 280,
          width: widthphon(context),

     child: Stack(
      children: [
        Column(children: [const SizedBox(height: 10,), 
  barcard(items[index], uid, controllivent),
  const SizedBox(height: 10,), 
          Expanded(
            flex: 3,
            child: ClipRRect(
          
                                    borderRadius: const BorderRadius.only(
          
                                        bottomLeft: Radius.circular(5),
          
                                        bottomRight: Radius.circular(5)),
          
                                    child:Stack(
                              children: [
                                Container(height: double.infinity,width: double.infinity,
                                child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                             bottomRight:  Radius.circular(20),bottomLeft: Radius.circular(20),),
                                            child:Hero(tag: index.toString(),
                                              child: CachedNetworkImage(
                                                height: double.infinity,
                                                width: double.infinity,
                                                                              fit: BoxFit.cover,
                                                                              imageUrl:items[index]['urlImage'].toString(),
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
                     child:   Container(child:Stack(
  children: <Widget>[
    // Stroked text as border.
    Text(
      items[index]['destination'],
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
      items[index]['destination'],
      style: TextStyle(
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
          child: Center(child: Text(" "+items[index]['datedubte'], 
          maxLines: 1,  overflow: TextOverflow.clip,textAlign: TextAlign.center,
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
             items [index]['price']+"DA",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        alignment: FractionalOffset.center,
        transform: new Matrix4.identity()
          ..rotateZ(0.88),
      ),
  ),
      ],
                            ),),
                        
                                    
                                    
                                    
                                
          )
        ],),
         Positioned(
      top: 55,left: 0, 
      right: 0,
      child: Center(
        child:InkWell(onTap: (){
                      Get.to(SceenProflileAll(token:"",
                        
                         id: items[index]['uid'], imageprofile:items[index]['photouser'], name:items[index]['username'], ));
                    },
                      child:  ClipRRect(
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
        ),
      )
      ) , 
   ],
    ),
  ),),
),
);
    }

