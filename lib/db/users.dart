


import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  final actualDate=DateTime.now();
  FirebaseDatabase _database=FirebaseDatabase.instance;
  Firestore _firestore=Firestore.instance;
  String ref="users";
  String userList="users";
  createUser(String id, Map value){
    _database.reference()
        .child("$ref/$id").set(value).catchError((e)=>{print(e.toString())});


    _firestore.collection(userList).document(id).setData(
        {'name': value['username'].toString(), 'gender': value['gender'].toString(), 'age': value['age'], 'email': value['email'].toString(), 'joinDate': DateTime.now(),
         }
    );


  }






}