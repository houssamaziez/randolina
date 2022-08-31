
    import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/ScreenHome/card/cardivnt.dart';

ListView listCard(List<QueryDocumentSnapshot<Object?>> items,uid, controllivent) {
      return ListView.builder(
shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
itemCount:items.length ,
itemBuilder: ((context, index) => 
cardivent(items, index, context, uid, controllivent)
));
    }

  