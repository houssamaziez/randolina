import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:video_compress/video_compress.dart';

import '../Screens/Home/Home.dart';

class Dailogcompress extends StatefulWidget {
  const Dailogcompress({Key? key}) : super(key: key);

  @override
  State<Dailogcompress> createState() => _DailogcompressState();
}

class _DailogcompressState extends State<Dailogcompress> {
  late Subscription subscription ;
double? progress;
@override
  void initState() {
    // TODO: implement initState

    subscription= VideoCompress.compressProgress$.subscribe((event) {

      setState(() {
        progress=event ;
      });
     });
    super.initState();
  }

@override
  void dispose() {
VideoCompress.cancelCompression();
subscription.unsubscribe();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final value=progress==null?progress : progress!/100;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [

          Text("Compress video !"),
SizedBox(height: 20,),
          LinearProgressIndicator(value:value , minHeight: 12,), 

          ElevatedButton(onPressed: (){
            VideoCompress.cancelCompression();
            Get.back();
          }, child: Text('Cancel'))
        ],
      ),
    );
  }
}







  class   VidecCompressApi{

    static Future <MediaInfo?> compress( File file)async{
try {
  await VideoCompress.setLogLevel(0);
  return   await VideoCompress.compressVideo(
 file.path,
quality: VideoQuality.LowQuality,
includeAudio: true);
} on Exception catch (e) {
  Get.snackbar('error', e.toString());
VideoCompress.cancelCompression();

}
    }
   }

