import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randolina/View/Screens/Registre/Signin/screenSignin.dart';
import 'package:randolina/const.dart';


 Align minureels(id,idpost, docs) {
    return Align(
alignment:Alignment.topRight,
child: Padding(
  padding: const EdgeInsets.only(right: 10, top: 30),
  child:   MyHomePage(id:id,idpost: idpost, docs:docs),
));
  }


class MyHomePage extends StatefulWidget {
      MyHomePage({Key? key, this.id,this.idpost, this.docs }) : super(key: key);
final id, idpost,docs;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton:  Image.asset('images/dots.png', 
            height: 25,),
            customItemsIndexes: const [4],
            customItemsHeight:3,
            items: [
              ...MenuItems.firstItems.map(
                        (item) =>
                    DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item,widget. id),
                        ),
              ),
              
          ],
            onChanged: (value) {
              MenuItems.onChanged(context, value as MenuItem,widget.idpost, widget.docs);
            },
            itemHeight: 30,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 160,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color:Colors.white.withOpacity(0.7),
            ),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
          ),
        ) ;
  }
}







class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [ report_gmailerrorred, share,delete,];

  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const report_gmailerrorred = MenuItem(text: 'Report', icon: Icons.report_gmailerrorred);

  static Widget buildItem(MenuItem item, id) {
    return  firebaseAuth.currentUser!.uid!=id && item==MenuItems.delete?Container() :Row(
      children: [
        Icon(
                item.icon,
                color: Colors.black,
                size: 22
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item, idpost, docs) async{
    switch (item) {
      case MenuItems.delete:
     
       await firestor
        .collection(docs).doc(idpost)
        .delete();
        break;

      case MenuItems.share:
      //Do something
        break;
      case MenuItems.report_gmailerrorred:
        var uid= firebaseAuth.currentUser!.uid;
  DocumentSnapshot<Map<String, dynamic>> post=await  firestor.collection("raport").doc(idpost).get();


  await  firestor.collection(docs).doc(idpost).update({"raport":FieldValue.arrayUnion([uid])});


    Get.back();
    
        
        break;
      
    }
  }
delet(id)async{
   
}

}
