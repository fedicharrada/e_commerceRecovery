import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce/imageList.dart';
import'package:e_commerce/component/HorizantalList.dart';
import'package:e_commerce/component/Products.dart';
import 'cart.dart';
import 'login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce/Provider/userProvider.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePage createState()=>_HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController _searchController=new TextEditingController();


  signOuuut()async {
    print('hello fediii signout');
    await UserProvider.initialize().signOut();
    Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>new Login ()));
  }


  @override
  Widget build(BuildContext context){
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.deepOrange),
        elevation: 0.1,
        backgroundColor: Colors.white,
        title: Container(
          height: MediaQuery.of(context).size.height*0.06,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[100],
            elevation: 1.0,
            child:Padding(
              padding: EdgeInsets.only(left:8),
              child: ListTile(
                title:  TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left:2.0, bottom: 7),
                      hintText: "Search...",
                      border: InputBorder.none),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "The search field cannot be empty";
                    }
                    return null;
                  },
                ),
                trailing: IconButton(icon:Icon(Icons.search, color: Colors.deepOrange,),
                  onPressed:(){} ,),

              ),
            ),
          ),
        ),
        actions: <Widget>[

          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
              ),
              onPressed: ()async {
                final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                await _firebaseAuth.currentUser().then((user){print(user.providerId);});
              })
        ],
      ),







      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text('Fedi'), accountEmail: Text('fedi@yahoo.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  backgroundImage: AssetImage('images/fedi.jpg'),
                  //child: Icon(Icons.person_outline),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.red
              ),

            ),
            InkWell(
              onTap: null,
              child: ListTile(
                title: Text('Home page'),
                leading: Icon(Icons.home, color: Colors.red,),
              ),
            ),


            InkWell(
              onTap: null,
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person ,color: Colors.red,),
              ),
            ),




            InkWell(
              onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>new Cart())),
              child: ListTile(
                title: Text('My orders'),
                leading: Icon(Icons.shopping_basket, color: Colors.red, ),
              ),
            ),





            InkWell(
              onTap: null,
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard, color: Colors.red,),
              ),
            ),

            InkWell(
              onTap: null,
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite, color: Colors.red,),
              ),
            ),

            Divider(),


            InkWell(
              onTap: null,
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.blueAccent),
              ),
            ),


            InkWell(
              onTap: null,
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.green,),
              ),
            ),


            InkWell(

              child: ListTile(
                title: Text('Log Out'),

                leading: Icon(Icons.call_missed_outgoing, color: Colors.red,),
              ),
              onTap: ()async{signOuuut();
              final GoogleSignIn _googlSignIn = new GoogleSignIn();
              final GoogleSignInAccount googleUserOut = await _googlSignIn.signOut();}
            ),


             




          ],
        ),
      ),

      body: ListView(
        children: <Widget>[
          myCarousel(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Categories'),

          ),

          ///////Horizantal list
          HorizontalList(),

          Padding(padding: const EdgeInsets.all(20.0),
            child: Text('Recent Product', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold
            ),),),



          /////GridView
          Container(
            height: 320.0,
            child: Products(),
          )

        ],
      ) ,
    );

  }


}



