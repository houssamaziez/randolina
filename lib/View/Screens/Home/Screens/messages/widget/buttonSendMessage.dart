import 'package:flutter/material.dart';

Align buttonSendMessage(_controllertext,controllerMessanger, idclien, idmsg) {
    return Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                  ),
                ),
                const SizedBox(width: 15,),
                  Expanded(
                  child:  TextField(controller: _controllertext,
                    decoration:const  InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
                FloatingActionButton(
                  onPressed: (){
                    if (_controllertext.text.isNotEmpty) {

controllerMessanger.sendmessageToAll(users:idclien, msg: _controllertext.text, idmsg: idmsg);
            _controllertext.clear();
 
            }
                  },
                  child: const Icon(Icons.send,color: Colors.white,size: 18,),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ],
              
            ),
          ),
        );
  }

 