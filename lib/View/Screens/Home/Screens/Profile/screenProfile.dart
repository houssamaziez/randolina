import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Home/Screens/Postview/screenPost.dart';
import 'package:randolina/View/Screens/Home/Screens/Profile/menu.dart';
import 'package:randolina/ct.dart';

class SceenProflile extends StatefulWidget {

    SceenProflile({Key? key}) : super(key: key);

  @override
  State<SceenProflile> createState() => _SceenProflileState();
}

class _SceenProflileState extends State<SceenProflile> {
 var  piceUser= "";

getpiceUser()async{
  var uid= firebaseAuth.currentUser!.uid;
  DocumentSnapshot userdocs=await firestor.collection("User").doc(uid).get();
  print((userdocs.data()! as Map <String, dynamic>)["photoProfil"]);
piceUser=   (userdocs.data()! as Map <String, dynamic>)["name"];
print(piceUser);
 return await (userdocs.data()! as Map <String, dynamic>)["photoProfil"];
}

int postnumber=0;

  @override
  Widget build(BuildContext context) {
    getpiceUser();
 var uid= firebaseAuth.currentUser!.uid;

    return Scaffold(
      backgroundColor: color1,
      body:  Stack(
            children: [ 
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: StreamBuilder(
            stream: firestor.collection('User').where("uid",isEqualTo:uid ).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var items = snapshot.data?.docs ?? [];




 if (snapshot.connectionState == ConnectionState.waiting) {
        return Column(children: [const Spacer(),
          spinkit,
          const Spacer(),const Spacer(),const Spacer(),const Spacer(),
          
          ],);
      } else if (snapshot.connectionState == ConnectionState.active
          || snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return Container(
                      height: heightphon(context,size: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50,
                          child: Row(children: [

                          const  Spacer(),
                          const Padding(
                              padding:  EdgeInsets.only(right: 30),
                              child: Text("Profile", style: TextStyle(color:Colors.white, fontSize: 25),),
            ), const Spacer(), 

],),

                            ), 
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children:  [
                                  CircleAvatar(radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(items[0]["photoProfil"]),
            ),
            Padding(
                              padding:  const EdgeInsets.all(8.0),
                              child: Text(items[0]["name"], style: const TextStyle(color:Colors.white, fontSize: 25),),
            ),
            ],
                              ),
                            )
            ,
   Padding(
                                padding:  const EdgeInsets.only(left: 15),
                                child: Text(items[0]["email"], style: const TextStyle(color:Colors.grey, fontSize: 17),),
            ),
              Padding(
                                padding:  const EdgeInsets.only(left: 15),
                                child: Text(items[0]["wilaya"], style: const TextStyle(color:Colors.grey, fontSize: 17),),
            ),
 const Padding(
                                padding:  EdgeInsets.only(left: 15),
                                child: Text("Bio: ", style: TextStyle(color:Colors.grey, fontSize: 17),),
            ),
            Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(height: 50,
           
           child: Row(children:[
                          const Spacer(),
                          Padding(
                            padding:  const EdgeInsets.all(8.0),
                            child: Text("${postnumber.toString()} posts", style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),),
                          ),const VerticalDivider(color: Colors.white),
                          Padding(
                            padding:  const EdgeInsets.all(8.0),
                            child: Text("47.2K followers", style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),),
                          ),const VerticalDivider(color: Colors.white),
                          Padding(
                            padding:  const EdgeInsets.all(7.0),
                            child: Text("124 following", style: TextStyle(color:Colors.white, fontSize: widthphon(context, size: 0.02)),),
                          ),
                          const Spacer(),

           ],),),
            ),
                        ],
                      ),
                    );
                 
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }




             }
                ),
              ),
          
              ListView(
                children: [
                  SizedBox(height: heightphon(context,size: 0.35)),
     Container(
                  decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), 
                  topRight: Radius.circular(20),

)
                  ),
               
                  
                  child: Column(children: [
                    const SizedBox(height: 15,),
                  
                    Container(width: 100,
                       height: 1,color: Colors.grey,
                    ),
// POST profile 

              StreamBuilder(
            stream: firestor.collection('Post').where("uid", isEqualTo: uid).orderBy("time", descending: true).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var items = snapshot.data?.docs ?? [];

 if (snapshot.connectionState == ConnectionState.waiting) {
        return   const Padding(
          padding: const EdgeInsets.all(100.0),
          child: spinkit,
        );
      } else if (snapshot.connectionState == ConnectionState.active
          || snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return 
                GridView.count(
                     physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,

  crossAxisCount: 3,
  children: List.generate(items.length, (index) {
postnumber =items.length;

    return Padding(
          padding: const  EdgeInsets.all(2.0),
          child: InkWell(onTap: (){

            Get.to(ScreenPost(time: items[index]["time"], details: items[index]["details"], username: items[index]["username"], photouser: items[index]["photouser"], urlImage:  items[index]["urlImage"], likes: items[index]["likes"], comentr: items[index]["comentr"], uid: uid, id: items[index]["id"]));
          },
            child: Card(color: Colors.blue.shade200,
              child:CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:items[index]["urlImage"],
                    placeholder: (context, url) => spinkit,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
            ),
          ),
    );
  }),
);
                    
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }





 }
               ),


                 SizedBox(height: heightphon(context,size: 0.72)),
 ],),
                  )
                ],
              ),
Align(
  
  alignment:Alignment.topRight,
  child: Padding(
    padding: const EdgeInsets.only(right: 10, top: 30),
    child: const MyHomePage(),
  )),
            ],
          
        
      ),
      
      
      );

  }
}