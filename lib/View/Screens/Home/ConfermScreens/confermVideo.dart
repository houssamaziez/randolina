import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/videocotroller.dart';
import 'package:randolina/View/Screens/Registre/widgets.dart';
import 'package:randolina/ct.dart';
import 'package:video_player/video_player.dart';

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
          onPressed: (){
            uploadvideocontroller.uploadvideo(detialsvideo: details, videopath:widget. videopath);
            },
        
        child:contr.islodeinvideo?spinkit: Icon(Icons.post_add),),
      ),
      body: SingleChildScrollView(child: Column(children: [
Text(widget. size.toString(), style: TextStyle(color: Colors.white),),


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