import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:randolina/const.dart';
class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;
  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }
  getUserData() async {
    List<String> thumbnails = [];
    var myVideos = await firestor
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }
    DocumentSnapshot userDoc =
        await firestor.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;
    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }
    var followerDoc = await firestor
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await firestor
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    firestor
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };
    update();
  }

  followUser() async {
    var doc = await firestor
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    if (!doc.exists) {
      await firestor
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(firebaseAuth.currentUser!.uid)
          .set({});
      await firestor
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await firestor
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(firebaseAuth.currentUser!.uid)
          .delete();
      await firestor
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }




 int likescont = 0;
 int postlength = 0;

getcontlike(id) async {
 // ignore: no_leading_underscores_for_local_identifiers
 int _likescontpost = 0;
 // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
 int _likescontvideo = 0;
  
        var myPost = await firestor
        .collection('Post')
        .where('uid', isEqualTo: id)
        .get();
        var myVideos = await firestor
        .collection('Videos')
        .where('uid', isEqualTo: id)
        .get();
        
  postlength = myPost.docs.length+ myVideos.docs.length;
update();
    for (int i = 0; i < myPost.docs.length; i++) {
  _likescontpost=_likescontpost+ myPost.docs[i]['likes'].length as int;
    }
      for (int i = 0; i < myVideos.docs.length; i++) {
  _likescontvideo=_likescontvideo+ myVideos.docs[i]['likes'].length as int;
    }
    likescont =_likescontpost+_likescontvideo;
    update();
}


int idext=0;
indextchange(index){
idext=index;
update();
print(idext);
}

}