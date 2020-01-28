import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/Provider/userProvider.dart';
import 'home.dart';
import 'package:e_commerce/db/users.dart';
import 'package:uuid/uuid.dart';




class Register extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<Register> {

  TextEditingController nametController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool emailexist=false;
  int age;



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserServices _userServices=UserServices();
  bool loading=false;
  String password, confirmPassword, email, fullname, gender;
  SharedPreferences prefences;
  String groupeValue="male";
  final GlobalKey<FormState> formRegister = GlobalKey<FormState>();
  var uid = Uuid();














  //==============  Register Function











  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    var w=MediaQuery.of(context).size.width;
    return Scaffold(

      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height,
              child: Image.asset('images/register.jpeg'
                  ,fit: BoxFit.fill,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  colorBlendMode: BlendMode.modulate
              ),
            ),






            Center(
              child: ListView(

                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4, left: 20, right: 20),
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                //  ==== loading visivility


                 Container(width: 20, padding: EdgeInsets.only(left: w*0.33, right: w*0.33),
                  child: Visibility(
                    visible: loading ?? true,
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  ),
                 ),








                  //SizedBox(height: 20,),
                  Container(width: MediaQuery.of(context).size.width*0.9,
                    //padding: EdgeInsets.only(top:50.0),
                    child: Form(
                      key: formRegister,
                      child: Column(
                        children: <Widget>[

                          //============== Full name
                          Padding(padding: const EdgeInsets.only(top:8.0),
                            child:Material(borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white.withOpacity(0.7),
                              child:Padding(padding: const  EdgeInsets.only(left: 12.0, top:5,bottom: 5,),
                                  child: TextFormField(style: TextStyle(fontWeight: FontWeight.w600,),
                                    decoration: InputDecoration(icon:Icon(Icons.person_outline, color: Colors.black.withOpacity(0.6),),
                                      hintText: 'Full Name', isDense: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),

                                    ),
                                    controller: nametController,
                                    validator: (val){
                                      if(val.isEmpty){return'Please enter your Full name';}
                                      if(val.length<5){return'You may forget to enter your Last name';}
                                      if(!val.contains("")){return'Please enter your First and Last name';}

                                    },
                                    onSaved: (val){fullname=val;},
                                  )),),),






                          //============ Gender

                          Container(height: 55,
                            child:Padding(padding: const EdgeInsets.only(top:8.0),
                            child:Material(borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white.withOpacity(0.7),
                              child:Padding(padding: const  EdgeInsets.only(left: 5.0,),
                                child:Row(
                            children: <Widget>[
                              Expanded(child: ListTile(title: Text("Male", textAlign: TextAlign.end,style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.w600),),
                              trailing: Radio(value: "Male",groupValue: groupeValue,onChanged: (e)=>valueChanged(e),),),),



                              Expanded(child: ListTile(title: Text("Female", textAlign: TextAlign.end,style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.w600),),
                                trailing: Radio(value: "Female",groupValue: groupeValue,onChanged: (e)=>valueChanged(e),),),),

                            ],
                          ),
                              ),),),),

                          //================







                          //======= Age

                          Padding(padding: const EdgeInsets.only(top:8.0),
                            child:Material(borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.7),
                                child:Padding(padding: const  EdgeInsets.only(left: 12.0, top:5,bottom: 5,),
                                  child: TextFormField(style: TextStyle(fontWeight: FontWeight.w600),
                                    // maxLength: 14, maxLengthEnforced: false,

                                    decoration: InputDecoration(icon:Icon(Icons.all_inclusive, color: Colors.black.withOpacity(0.6),),
                                        hintText: 'Age',isDense: true,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        )

                                    ),

                                    obscureText: true,
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    validator: (val){
                                      if(val.isEmpty){return'Please enter your Age';}
                                      if(int.parse(val)<7 || int.parse(val)>100){return 'Please Verify your age';}
                                    },
                                    onSaved: (val){age=int.parse(val);},
                                    onChanged: (val){age=int.parse(val);},
                                  ),)),),










                          //===========Email field
                          Padding(padding: const EdgeInsets.only(top:8.0),
                            child:Material(borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white.withOpacity(0.7),
                              child:Padding(padding: const  EdgeInsets.only(left: 12.0, top:5,bottom: 5,),
                                  child: TextFormField(style: TextStyle(fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(icon:Icon(Icons.email, color: Colors.black.withOpacity(0.6),),
                                      hintText: 'Email Adress', isDense: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),

                                    ),
                                    autofocus: emailexist ? true: false,
                                    validator: (val){
                                      if(val.isEmpty){return'Please enter your Email';}
                                      Pattern pattern=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                      RegExp regex=new RegExp(pattern);
                                      if(!regex.hasMatch(val)){return 'Please make sure your email is validate';}
                                    },
                                    onSaved: (val){email=val;},
                                    onChanged: (val){email=val;},
                                  )),),),




                          //============password field

                          Padding(padding: const EdgeInsets.only(top:8.0),
                            child:Material(borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.7),
                                child:Padding(padding: const  EdgeInsets.only(left: 12.0, top:5,bottom: 5,),
                                  child: TextFormField(style: TextStyle(fontWeight: FontWeight.w600),
                                    // maxLength: 14, maxLengthEnforced: false,

                                    decoration: InputDecoration(icon:Icon(Icons.lock_outline, color: Colors.black.withOpacity(0.6),),
                                        hintText: 'Password',isDense: true,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        )

                                    ),

                                    obscureText: true,
                                    controller: passwordController,
                                    validator: (val){
                                      if(val.isEmpty){return'Please enter your Password';}
                                      if(val.length<6){return 'Password has to be at least 6 characters';}
                                    },
                                    onSaved: (val){password=val;},
                                    onChanged: (val){password=val;},
                                  ),)),),



                             //=========== Confirm Password
                          Padding(padding: const EdgeInsets.only(top:8.0),
                            child:Material(borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.7),
                                child:Padding(padding: const  EdgeInsets.only(left: 12.0, top:5,bottom: 5,),
                                  child: TextFormField(style: TextStyle(fontWeight: FontWeight.w600),
                                    // maxLength: 14, maxLengthEnforced: false,

                                    decoration: InputDecoration(icon:Icon(Icons.lock_outline, color: Colors.black.withOpacity(0.6),),
                                        hintText: 'Confirm Password',isDense: true,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        )

                                    ),

                                    obscureText: true,
                                    validator: (val){
                                      if(val.isEmpty){return'Please Confirm your Password';}
                                     if(val!=password){return 'Please enter the Same password';}
                                    },
                                    onSaved: (val){confirmPassword=val;},
                                  ),)),),








                          SizedBox(height:30.0),

                          //========SignIn button
                          Container(
                            //width: 250.0,
                              child: Align(
                                alignment: Alignment.center,
                                child: RaisedButton(elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0)),
                                  color: Colors.red,
                                  child: Center(
                                    child:   Text(
                                      'Register',textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white,fontSize: 18.0,fontFamily: 'Raleway'),
                                    ),


                                    //Image.asset('images/google.png',scale: 20.0 ,),

                                    //SizedBox(width:10.0),

                                  ),
                                  onPressed: ()async{



                                        final formdata = formRegister.currentState;
                                         if (formdata.validate()) {formdata.save();
                                         setState(() {
                                          // loading=true;
                                         });
                                           String pass = passwordController.text;
                                           String myname = nametController.text;
                                           String myemail = emailTextController.text;
                                          // user.signUp(fullname,email, password, gender);
                                           if(await user.signUp(fullname,email, password, gender, age)==true){ print('pass to home page');
                                             Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>new HomePage()));}
                                         } else {print ('cant go home page');}
                                        setState(() {
                                          //loading=false;
                                        });
                                  },
                                ),
                              )
                          ),





















                          //======== Google SignIn button




                        ],
                      ),

                    ),
                  ),


                ],
              ),
            ), ],
        ),),




    );
  }

  valueChanged(e) {
    setState(() {
      if(e=="Male"){groupeValue=e;
      gender=e;}
      else if(e=="Female"){groupeValue=e;
      gender=e;}
    });
  }






}


