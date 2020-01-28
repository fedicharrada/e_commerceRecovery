
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'home.dart';
import 'package:e_commerce/component/loading.dart';
import 'Register.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/Provider/userProvider.dart';
import 'package:e_commerce/db/users.dart';



class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Signin APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff9C58D2),
      ),
      home: GoogleSignApp(),
    );
  }
}

class GoogleSignApp extends StatefulWidget {


  @override
  _GoogleSignAppState createState() => _GoogleSignAppState();
}

class _GoogleSignAppState extends State<GoogleSignApp> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  SharedPreferences prefences;
  final GlobalKey<FormState> formState=GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scafoldState=GlobalKey<ScaffoldState>();
  String email, password;
  bool loading=false;
  bool islogin=false;
  UserServices _userService=UserServices();




  //============== Sign In with Google==============
  Future<FirebaseUser> _GsignIn(BuildContext context) async {
    setState(() {
      loading=true;
    });
   prefences =await SharedPreferences.getInstance() ;


    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser userDetails = authResult.user;

    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);
    loading=false;
   print(userDetails.metadata.toString());


    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );


    _userService.createUser(userDetails.uid,
        {
          "username": userDetails.displayName,
          "email": userDetails.email,
          "userId": userDetails.uid,
         // "gender": userDetails,

        });

    await prefences.setString("id", userDetails.providerId);
    await prefences.setString("id", userDetails.displayName);
    await prefences.setString("id", userDetails.photoUrl);
    await prefences.setString("id", userDetails.email);
    setState(() {
      islogin=true;
      loading=false;
    });




    if(details!=Null){Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>new HomePage()));}


    return userDetails;





  }












//===============Widget Build
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return  Scaffold(
      key: scafoldState,
      body:
      user.status==Status.Authenticating ? Loading(): Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height,
              child: Image.asset('images/m2m.jpeg'
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



                //SizedBox(height: 20,),
                Container(width: MediaQuery.of(context).size.width*0.9,
                  //padding: EdgeInsets.only(top:50.0),
                  child: Form(
                  key: formState,
                  child: Column(
                    children: <Widget>[





                         // ==============  Visibile Loading


                      Container(
                        child:Visibility(
                        visible: loading ?? true,
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.white.withOpacity(0.1),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ),
                      ),


                      //===========Email field
                  Padding(padding: const EdgeInsets.only(top:8.0),
                      child:Material(borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.3),
                          child:Padding(padding: const  EdgeInsets.only(left: 12.0, top:5,bottom: 5,),
                      child: TextFormField(
                        decoration: InputDecoration(icon:Icon(Icons.email, color: Colors.black.withOpacity(0.6),),
                        hintText: 'Email Adress', isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),

                        ),
                        validator: (val){
                          if(val.isEmpty){return'Please enter your Email';}
                        Pattern pattern=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                          RegExp regex=new RegExp(pattern);
                          if(!regex.hasMatch(val)){return 'Please make sure your email is validate';}
                          },
                        onSaved: (val){email=val.toString().trim();},
                      )),),),




                      //============password field

                      Padding(padding: const EdgeInsets.only(top:8.0),
                        child:Material(borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.3),
                          child:Padding(padding: const  EdgeInsets.only(left: 12.0, top:5,bottom: 5,),
                              child: TextFormField(
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
                                validator: (val){
                                  if(val.isEmpty){return'Please enter your Password';}
                                  if(val.length<6){return 'Password has to be at least 6 characters';}
                                },
                                onSaved: (val){password=val;},
                              ),)),),











                      SizedBox(height:10.0),

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
                                  'Login',textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white,fontSize: 18.0,fontFamily: 'Raleway'),
                                ),


                                  //Image.asset('images/google.png',scale: 20.0 ,),

                                  //SizedBox(width:10.0),

                              ),
                              onPressed: () async{
                              final formdata=formState.currentState;
                              if(formdata.validate()){
                                formdata.save(); print('current email ${email}');

                             if(await user.signIn(email, password)==true){
                                print(' signi In is true');
                                await Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>new HomePage()));

                                     formdata.reset(); print('going to home page');
//
                              }
//                              else{ Fluttertoast.showToast(msg: 'Verify your data !', backgroundColor: Colors.red.withOpacity(0.5), gravity: ToastGravity.TOP,
//                                  timeInSecForIos: 2,
//                                  textColor: Colors.white,
//                                  fontSize: 16.0);
//
//                              print('cant go to home page ..');}
                             }

                              },


                            ),
                          )
                      ),









                      SizedBox(height:10.0),

                      //======== Register button
                      Container(
                        //width: 250.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText( text:TextSpan(
                              style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                text: "Don't have an account ? click here to "
                              ),

                              TextSpan(
                                text: "Sign Up", style: TextStyle( color: Colors.red, fontWeight: FontWeight.w400,
                                fontSize: 16,),
                                  recognizer: new TapGestureRecognizer()..onTap = () {Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>new Register()));}
                              )

                              ]
                            ),
                            ),
                          )
                      ),










                SizedBox(width: MediaQuery.of(context).size.width,
                  child:

                Divider(color: Colors.white.withOpacity(0.7),
                thickness: 2,),),
                 Center(child: Text('-- Other Sign In Option --', style: TextStyle(color: Colors.white,fontSize: 13.0, fontFamily: 'Raleway'),),),







                      //======== Google SignIn button

                      SizedBox(height:20.0),
                      Container(
                        //width: MediaQuery.of(context).size.width*0.5,

                          child: Align(
                            alignment: Alignment.center,
                            child: RaisedButton(elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0)),
                              color: Color(0xffffffff),
                              child: Center(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    Image.asset('images/google.png',scale: 30.0 ,),
                                    //SizedBox(width: 10,),

                                    //SizedBox(width:10.0),
                                    Text(
                                      'oogle',
                                      style: TextStyle(color: Colors.red,fontSize: 15.0, fontWeight: FontWeight.bold, ),
                                    ),
                                  ],),),
                              onPressed: () => _GsignIn(context)
                                  .then((FirebaseUser user) => print(user))
                                  .catchError((e) => print(e)),
                            ),
                          )
                      ),



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






}



class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails,this.userName, this.photoUrl,this.userEmail, this.providerData);
}


class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}



