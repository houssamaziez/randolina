
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/Controller/iventController.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/editivent.dart';
import 'package:randolina/const.dart';

class ProfileEvent extends StatefulWidget {
    ProfileEvent({Key? key,required this.image,required this.tag,required this.list}) : super(key: key);
final     list;
final String image, tag;

  @override
  State<ProfileEvent> createState() => _ProfileEventState();
}

class _ProfileEventState extends State<ProfileEvent> {
var listlenghtunconfimed =0;

var listlenghtconfimed =0;

var controllerivent= Get.put(IventsController());
@override
  void initState() {
  // listlenghtconfimed=  widget. list['confermnum'].length;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

 
    return Scaffold(backgroundColor: Colors.white,
       body: ListView(children: [
    Stack(
  children: [
        Container(
      width: widthphon(context),
      height: heightphon(context, size: 0.6),
      decoration:const BoxDecoration(
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),
        )
      ),
      
      child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40)),
                            child: Hero(
                                    tag: widget.tag,
                                    child: CachedNetworkImage(width: double.infinity,
                                                                fit: BoxFit.cover,
                                                                imageUrl:widget.list['urlImage'].toString(),
                                                                placeholder: (context, url) => spinkit,
                                                                errorWidget: (context, url, error) =>
                                                                    const Icon(Icons.error),
                                                              ),
                                  ), ),
    ),
 Padding(
   padding: const EdgeInsets.all(8.0),
   child: CircleAvatar(backgroundColor: Colors.white,
     child: Padding(
       padding: const EdgeInsets.only(left: 3),
       child: IconButton(onPressed: (){
        Get.back();
       }, icon:const Icon(Icons.arrow_back_ios, color: Colors.black,)),
     ),
   ),
 )
  ],
),
 const SizedBox(height: 10,), 
 Center(child: Text(
  widget.list["destination"], style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),)),
 const SizedBox(height: 40,),
 
const SizedBox(height: 40,),
        listparti(true),
         Divider(
              height: 1,
              color: Colors.grey,
            ),
const SizedBox(height: 40,),

     
const SizedBox(height: 40,),

        listparti(false),
const SizedBox(height: 20,),  
    Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(
    children: [
      const Text('price:', style:  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
     const Spacer() 
   ,
    Text('${widget.list["price"].toString()} DA', style: const TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),),],
 
  ),
),
  Padding(
 padding:  const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
 child: InkWell(onTap: (){

  Get.to(EditIvent(
    datedubteivent: widget.list['time'],
    imagurl:widget.list['urlImage'] ,
    details:widget.list["details"]  , destination: widget.list["destination"], price1:widget.list["price"]  , distance:widget.list["distance"]  , nombresplaces:widget.list["nombresplaces"] , datedubte:widget.list["datedubte"] , datefine:widget.list["datefine"] , id:widget.list["id"],   ));
 },
   child: Container(
   decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius:const BorderRadius.only(
      topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(0.3),
        spreadRadius: 3,
        blurRadius: 5,
        offset: const Offset(0, 3), // changes position of shadow
      ),
 
    ],
 ),
 child:   const Center(child: const Text("Edit",style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),),),
    height: 50, 
   width: double.infinity,
   ),
 ),
 )
,     ],),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> listparti(
isconferm
  ) {
    return StreamBuilder(
          stream:firestor.collection('Ivent').doc( widget.list["id"]) .collection('participate').where("conferm",isEqualTo: isconferm).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            List items = snapshot.data?.docs ?? [];
            listlenghtconfimed=items.length;
      if (snapshot.connectionState == ConnectionState.waiting) {
         return const Padding(
        padding:  EdgeInsets.all(100.0),
        child: spinkit,
      );
    } else if (snapshot.connectionState == ConnectionState.active
        || snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        return 
         Column(
           children: [  Row(
    children: [
        Padding(
       padding:  EdgeInsets.all(8.0),
       
       child: Text(
       isconferm==true? "Confirmed List: ":"Unconfirmed list:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
 ),Spacer(),
     Padding(
       padding:  EdgeInsets.all(12.0),
       
       child: Text(
       listlenghtconfimed.toString()+"/"+widget.list["nombresplaces"], style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500 , color: Colors.grey
        ),),
 ),
    ],
  ),

             ListView.builder(
 physics:const NeverScrollableScrollPhysics(),
shrinkWrap: true,
itemCount:  items.length,
itemBuilder: 
 ( context, indext) {
  print(items.isEmpty);

  isconferm==true?listlenghtconfimed=items.length: listlenghtunconfimed =items.length;

  return   items.isEmpty?Text("List is empty", style: TextStyle(color: Colors.black),):  newMethod(indext,items, context, widget.list["id"], isconferm);
}
),
           ],
         );
} else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
 }
             );
  }

    newMethod(int indext, list,context, id, isconferm) {
    return Container(
      width: heightphon(context),
      height: 93,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(onTap: (){
                 Get.defaultDialog(title: "Participate",
content:isconferm==true? Text('Do you want to Delete your participation in the trip?'):Text('Do you want to confirm your participation in the trip?'),
  cancel: TextButton(onPressed: (){
    setState(() {
  Navigator.pop(context);

  
});
}, child: const Text("cancel")),
  confirm: TextButton(onPressed: (){
 isconferm==true?  controllerivent.deletpart(list[indext]['uid'], id): (
   listlenghtconfimed+1<=int.parse(widget.list["nombresplaces"])?
  
  controllerivent.confermpart(list[indext]['uid'], id) :
  Get.snackbar('Completd', "List complte"))
  
  ;
  Navigator.pop(context);
setState(() {
  
});


}, child: const Text("confirm")));
              },
                child: Card(
                   color: isconferm==true?  Color.fromARGB(255, 219, 251, 217):Color.fromARGB(255, 254, 208, 205),
                  elevation: 4,
                
                  child: ListTile(
                  trailing: const Icon(Icons.phone, color: Colors.blue,),
                  subtitle:  Text(list[indext]['phone'],  style:const TextStyle( color: Colors.blue)),
                  leading:CircleAvatar(backgroundColor: Colors.grey,
                    radius: 24,
                    backgroundImage: NetworkImage(list[indext]['photoProfil'].toString()),),
                  title:Text(list[indext]['username']) ,),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          IconButton(onPressed: (){}, icon: Stack(
            children: [
              Center(
                child: Image.asset(
                  
                  "images/classment .jpg", height: 100,width: 200, fit: BoxFit.cover,),
              ),
              Center(child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text("${indext+1}", style:const TextStyle(fontWeight:FontWeight.bold, color: Colors.blue) ,),
              ))
            ],
          ))
        ],
      ),
    );
  }
}
