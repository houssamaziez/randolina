import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

class RereshLoadmor extends StatefulWidget {
    RereshLoadmor({Key? key,required this.widgetref}) : super(key: key);
final widgetref;
  @override
  State<RereshLoadmor> createState() => _RereshLoadmorState();
}

class _RereshLoadmorState extends State<RereshLoadmor> {
  
  Future<void> loadFirstData() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
      });
    });
  }
 @override
  void initState() {
    super.initState();
    loadFirstData();
  }
  @override
  Widget build(BuildContext context) {
      return RefreshLoadmore(key:widget. key,
            onRefresh: loadFirstData,
            onLoadmore: () async {
              await Future.delayed(Duration(seconds: 1), () {
                setState(() {
                });
              
              });
            },
         
            isLastPage: false,
            child:  widget.widgetref
          );
 
  }
}