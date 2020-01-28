import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_commerce/db/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:e_commerce/Pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  FirebaseUser get user => _user;
  Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();


  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }




  //================================= SDign In

  Future<bool> signIn(String email, String password)async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('authenticatedd');
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      print('unauthenticatedd');
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  //==============================================================================






// ==================== Sign Up
  Future<bool> signUp(String name,String email, String password, String gender,int age )async{
    try{
      _status = Status.Authenticating;
      notifyListeners();


        await _auth.createUserWithEmailAndPassword(email: email, password: password)
            .then((user) =>
        {
          _userServices.createUser(user.user.uid,
              {
                "username": name,
                "email": email,
                "userId": user.user.uid,
                "gender": gender,
                "age" : age,

              }
          )
        });

      return true;
    }catch(e){
      if(e is PlatformException) { print(e);
      if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        print('already useeeed');
        Fluttertoast.showToast(msg: 'This Email Is Already Exist !', backgroundColor: Colors.red.withOpacity(0.5), gravity: ToastGravity.TOP,
            timeInSecForIos: 2,
            textColor: Colors.white,
            fontSize: 16.0);

      }
      }



      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }




  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    print("log is done");
    return result;
  }



  Future<void> _onStateChanged(FirebaseUser user) async{
    if(user == null){
      _status = Status.Unauthenticated;
    }else{
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}

