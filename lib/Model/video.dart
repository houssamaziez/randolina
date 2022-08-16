import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
String username, uid, id, caption , videoUrl , thumbnial, profilephoto;
List likes;
int comentr, shereCount;
Video(
{
 required this.username,
required this.uid,
required this.id,
required this.likes,
required this.caption,
required this.videoUrl,
required this.thumbnial,
required this.profilephoto,
required this.comentr,
required this.shereCount,}
);

 Map <String , dynamic> tojeson()=>{
 'username':   username, 
  'uid':  uid, 
  'id': id,
 'likes':  likes,
 'caption':
  caption , 
 'videoUrl': videoUrl ,
 'thumbnial':  thumbnial, 
 'profilephoto':  profilephoto,
  'comentCount': comentr,
  'comentr': comentr,
   'shereCount': shereCount
 };


 static Video fromSnap(DocumentSnapshot snp){

  var snashot=snp.data() as Map<String , dynamic> ;
  return Video(
  username: snashot['username'],
   uid: snashot['uid'],
    id:  snashot['id'],
     likes: snashot['likes'],
      caption: snashot['caption'],
       videoUrl: snashot['videoUrl'],
        thumbnial: snashot['thumbnial'],
         profilephoto: snashot['profilephoto'],
          comentr: snashot['comentr'], 
          shereCount: snashot['shereCount']);
 }
}
