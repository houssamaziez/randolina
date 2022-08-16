  import 'package:flutter/material.dart';
import 'package:randolina/ct.dart';
int indextlist=-1;

AppBar appbar({isback= false, function}) {
    return AppBar(
      
      leading:isback? IconButton(onPressed:function, icon:const Icon(Icons.arrow_back_ios_new_outlined)):Container(),
      elevation: 0,backgroundColor: Colors.transparent,
      title: Container(
      width: 250,height: 250,
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Center(
          child: Hero(
                 tag: "appbarimage", 

            child: Image.asset("images/appbarimage.png",
                filterQuality:FilterQuality.high ,
                ),
          ),),
       )),
      centerTitle: true,
    );
  }


     button({function,required title,required istrue, isloading=false }) {
    return InkWell(
         borderRadius: const BorderRadius.all(Radius.circular(20)),
        onTap:  (){
          function();
        },
        child: Container(
          decoration:  BoxDecoration(
            color:istrue? Colors.grey:Color.fromARGB(255, 53, 149, 228),
            borderRadius:const BorderRadius.all(Radius.circular(20))),
          width: 150,height: 40,
        child: Center(child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20),),),),
      );
  }

class Cardchos{
final image, title, ischos;

  Cardchos( this.image, this.title, this.ischos);

}

var listchoscard= [

  Cardchos("images/1.png", "Hiking Club", false),
  Cardchos("images/2.png", "User", false),
  Cardchos("images/3.png", "Agency", false),
  Cardchos("images/4.png", "Store", false),

];

bool ischos=false;






  textfield({title, onChanged , controller, linamx , lin=1, typeKeyboard=TextInputType.name}) {

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(width: double.infinity,
         decoration:  BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius:const BorderRadius.all(Radius.circular(15))),
       
        child: TextField(
          keyboardType: typeKeyboard,
          maxLength: linamx,
          controller: controller,  maxLines: 5,
           // <-- SEE HERE
  minLines: lin,
          onChanged:onChanged ,
decoration: InputDecoration(
  
  border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
  hintText: title,
),
),
      ),
    );
  }
  textfieldform({title, onChanged , controller, linamx , lin=1, typeKeyboard=TextInputType.name}) {

final _formKey = GlobalKey<FormState>();
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(width: double.infinity,
         decoration:  BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius:const BorderRadius.all(Radius.circular(15))),
       
        child: TextField(
          key: _formKey,
          keyboardType: typeKeyboard,
          maxLength: linamx,
          controller: controller,  maxLines: 5,
           // <-- SEE HERE
  minLines: lin,
          onChanged:onChanged ,
decoration: InputDecoration(
  
  border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
  hintText: title,
),
),
      ),
    );
  }