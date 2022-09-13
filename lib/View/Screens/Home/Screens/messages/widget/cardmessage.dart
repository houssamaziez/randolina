import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../const.dart';

class Cardmessage extends StatefulWidget {
   Cardmessage({Key? key,required this.snapshot2,required this.dateFormat,required this.msg,required this.time,required this.controllerMessanger,required this.idmsgeuser}) : super(key: key);
  final snapshot2,dateFormat,msg, idmsgeuser,time, controllerMessanger;
  @override
  State<Cardmessage> createState() => _CardmessageState();
}
class _CardmessageState extends State<Cardmessage> {
  @override
  Widget build(BuildContext context) {
     
       return ListTile(
              leading: SizedBox(width: 50,height: 50,
                child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                      child: CachedNetworkImage(width: double.infinity,
                                                                              fit: BoxFit.cover,
                                                                              imageUrl:widget.snapshot2.data["photoProfil"].toString().toString(),
                                                                              placeholder: (context, url) => spinkit,
                                                                              errorWidget: (context, url, error) =>
                                                                                  const Icon(Icons.error),
                                                                            ),
                                    ),
              ),
                                  title: Text(widget. snapshot2.data["name"].toString()),
                                  subtitle:Text(widget.msg is List?"Object" :widget.msg.toString(), style: TextStyle(color: widget.msg.toString()=='New follower'||widget.idmsgeuser!=firebaseAuth.currentUser!.uid?Colors.blue:Colors.grey),maxLines: 1, overflow:TextOverflow.clip ) ,trailing:Text(widget.dateFormat.format(DateTime.parse(widget.time))   .toString()) ,
            );
  
  }
}