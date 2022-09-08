import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Controller/ControllerMessanger/CotrollerMessangerAll.dart';
import '../../../../../../Controller/eventController.dart';
import '../../../../../../const.dart';
import '../../../../../EmailSend/sendemail.dart';

class ScreenPart extends StatefulWidget {
final  list, items, isconferm;
  const ScreenPart({Key? key,required this.list,required this.items,required this.isconferm,}) : super(key: key);

  @override
  State<ScreenPart> createState() => _ScreenPartState();
}

class _ScreenPartState extends State<ScreenPart> {
  var listlenghtunconfimed =0;

var listlenghtconfimed =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(shape: shape, backgroundColor: Colors.white, centerTitle: true,
      title: Text(widget. isconferm==true? "Confirmed List ":"Unconfirmed list", style: TextStyle(color: Colors.black),),
      leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.black,)),),
      body: StreamBuilder(
          stream:firestor.collection('Ivent').doc( widget.list["id"]) .collection('participate').where("conferm",isEqualTo:widget. isconferm).snapshots(),
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
           children: [
            
 listl(items,widget. isconferm)
           
           ],
         );
} else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
 })
             );
  }

   ListView listl(List<dynamic> items, isconferm) {
    return ListView.builder(
 physics:const NeverScrollableScrollPhysics(),
shrinkWrap: true,
itemCount: items.length,
itemBuilder: 
 ( context, indext) {
print(items.isEmpty);


return   items.isEmpty?Text("List is empty", style: TextStyle(color: Colors.black),):  newMethod(indext,items, context, widget.list["id"], isconferm);
}
);
  }
var controllerivent= Get.put(IventsController());

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
  Get.snackbar('Completd', "List complte"));
  
  Navigator.pop(context);

setState(() {
  
});


}, child: const Text("confirm")));
              },
                child: Card(
                   color: isconferm==true?  Color.fromARGB(255, 219, 251, 217):Color.fromARGB(255, 254, 208, 205),
                  elevation: 4,
                
                  child: ListTile(
                  trailing: IconButton(onPressed: ()async{
var _controllerUser=Get.put(ControllerMessanger());
 var _data= await  _controllerUser.getdatauser(list[indext]['uid']);
 if (_data!=null) {
  
      // launchCaller(_data["phone"].toString());
   return;
 }
 },
                    icon: const Icon(Icons.phone, color: Colors.blue,)),
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