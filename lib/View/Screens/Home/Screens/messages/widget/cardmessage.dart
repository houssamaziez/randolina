import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../../const.dart';

class Cardmessage extends StatefulWidget {
   Cardmessage({Key? key,required this.snapshot2,required this.dateFormat,required this.msg,required this.time,required this.controllerMessanger}) : super(key: key);
  final snapshot2,dateFormat,msg,time, controllerMessanger;
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
                                  subtitle:Text(widget.msg.toString()) ,trailing:Text(widget.dateFormat.format(DateTime.parse(widget.time))   .toString()) ,
            );
  
  }
}