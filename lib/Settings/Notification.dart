import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}
 notificatioon({url,data})async{
var c='c5iWx_oYT5-jQOok-AB38d:APA91bEReWnIWLIj0snmq3wuAZ1oVQZeWW0vMAQ2h6__phvIVF_JagCulGAUg2KFdb2zKcP3DBuSSta-n9wdivu0B48IRpYOM1Om8iRyOMzrWbkf9sCYevByLtJH00BNoDg6xcnfPgKM';


  
 var progress=await http.post(Uri.parse("https://unwrapped-ceremony.000webhostapp.com/phptest/Notification.php"),body: {
   'token':c,
  'message':'cdc' ,
'username':"é"
 } );
try {
  if (progress.statusCode==200) {
var  responssbody= jsonDecode(    progress.body);
return responssbody;


  } else {
    print(progress.statusCode);
    
    
  }
} catch (e) {
    print(e.toString());
  
}

}   
         
class _FirstPageState extends State<FirstPage> {
    FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;
   String token1="";

  @override
  void initState() {
    super.initState();
    firbasecloudMessaging_listeners();
  }

    firbasecloudMessaging_listeners(){
_firebaseMessaging.getToken().then((value) {
 print("token is :"+value.toString());
 token1=value.toString();
 setState(() {
   
 });
});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: ()    {
              // getQue();
               notificatioon( );
              },
              color: Colors.orange,
              padding: EdgeInsets.all(10.0),
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.notifications,color: Colors.white),
                  SizedBox(height: 10,),
                  Text("Send",style: TextStyle(
                      color: Colors.white
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
    getQue() async {

    if(token1.isNotEmpty){
var response= await http.post(Uri.parse("https://unwrapped-ceremony.000webhostapp.com/phptest/Notification.php"), body: {
  'token':token1
});
// print(  json.decode(response.body)
// );
    }
    else{
      print("Token is null");
    }
  }
}
var c='c5iWx_oYT5-jQOok-AB38d:APA91bEReWnIWLIj0snmq3wuAZ1oVQZeWW0vMAQ2h6__phvIVF_JagCulGAUg2KFdb2zKcP3DBuSSta-n9wdivu0B48IRpYOM1Om8iRyOMzrWbkf9sCYevByLtJH00BNoDg6xcnfPgKM';