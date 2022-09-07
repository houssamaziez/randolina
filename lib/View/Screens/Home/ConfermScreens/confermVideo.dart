import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/videocotroller.dart';
import 'package:randolina/View/Screens/Registre/widgets.dart';
import 'package:randolina/const.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
class ConfrVideo extends StatefulWidget {
var ky = GlobalKey();
   ConfrVideo({Key? key,required this.videofile,required this.videopath,required this.size}) : super(key: key);
final videofile, size;
final videopath;
  @override
  State<ConfrVideo> createState() => _ConfrVideoState();
}
class _ConfrVideoState extends State<ConfrVideo> {
late VideoPlayerController videocontroller;
  var uploadvideocontroller= Get.put(VideoController());
String details="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videocontroller= VideoPlayerController.file(widget.videofile);
    });
    videocontroller.initialize();
    videocontroller.play();
    videocontroller.setVolume(1);
    videocontroller.setLooping(true);
  }
       uploadVideo( videoFile) async{
        uploadvideocontroller.index(true);
  var data;
    var uri = Uri.parse(urlserverfile);
    var request = new MultipartRequest("POST", uri);
    var multipartFile = await http. MultipartFile.fromPath("files", videoFile);
    request.files.add(multipartFile);
    StreamedResponse response = await request.send();
  response.stream.transform(utf8.decoder).listen((value)async {
    print(value);
                 await    uploadvideocontroller.uploadvideo(context,
                     videourcl: value, 
                      detialsvideo: details, videopath:widget.videopath);
       
 uploadvideocontroller.index(false);

    });
 
 uploadvideocontroller.index(false);

    if(response.statusCode==200){
      print("Video uploaded");

      return data;
    }else{
      print("Video upload failed");

      return data;

    }
    
  }
          
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videocontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1.withOpacity(0.2),
      floatingActionButton: GetBuilder<VideoController>(init: VideoController(),
        builder:(contr)=> FloatingActionButton(
          backgroundColor: color1,
          onPressed: ()async{
           
             await uploadVideo(widget.videopath);   
   
             
            },
        
        child:contr.islodeinvideo?spinkit: Icon(Icons.post_add),),
      ),
      body: SingleChildScrollView(child: Column(children: [



        SizedBox(width: widthphon(context),
          height:heightphon(context, size: 0.897),
          child: VideoPlayer(
            
            videocontroller, ),
        ),


Padding(
  padding: const EdgeInsets.only(right: 75),
  child:   Container(child: 
  
        textfield( onChanged: (val){setState(() {
          details=val;
        });} ,  title: "Details of video")
  
  ,),
)      ],),),
    );
  }
}