import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/Pages/home.dart';
import 'package:e_commerce/component/cardProduct.dart';

class Cart extends StatefulWidget{
   @override
  _Cart createState()=>_Cart();
}

class _Cart extends State<Cart>{
  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.red,
        title: InkWell(onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>new HomePage())),
          child:Center(
            child: Text('Shopping', style: TextStyle(color: Colors.white),),),),
        actions: <Widget>[

        ],
      ),
      body: new CartProduct(),



      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: Text('Total:  '),
              subtitle: Text("\$230"),
            ) ,),


            Expanded(
              child: MaterialButton(
                onPressed: (){},
                child: Text('Check Out', style: TextStyle(color: Colors.white),),
             color: Colors.red, ),

            )
          ],
        ),
      ),

    );



  }


}