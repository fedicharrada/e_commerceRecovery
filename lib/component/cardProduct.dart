
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartProduct extends StatefulWidget{
  @override
  _CartProduct createState()=>_CartProduct();
}

class _CartProduct extends State<CartProduct>{
  var Product_card_List=[
  {
  "name":"Blazer1",
  "picture":"images/products/blazer1.jpeg",
  "price":58,
    "Size": "M",
    "Color": "Black",
    "Quantity": 1,
},

    {
      "name":"hills",
      "picture":"images/products/hills1.jpeg",
      "Old price":100,
      "price":78,
      "Size": "L",
      "Color": "red",
      "Quantity": 2,
    },

    ];



  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Product_card_List.length,
        itemBuilder: (context, index){
          return Single_card_product(
            card_prod_name: Product_card_List[index]["name"],
            card_prod_color: Product_card_List[index]["Color"],
            card_prod_quantity: Product_card_List[index]["Quantity"],
            card_prod_size: Product_card_List[index]["Size"],
            card_prod_picture: Product_card_List[index]["picture"],
            card_prod_price: Product_card_List[index]["price"],
          );} );

  }
  }



  class Single_card_product extends StatelessWidget{

    final card_prod_name;
    final card_prod_picture;
    final card_prod_price;
    final card_prod_size;
    final card_prod_color;
    final card_prod_quantity;

    Single_card_product({this.card_prod_name, this.card_prod_picture, this.card_prod_price, this.card_prod_size, this.card_prod_color, this.card_prod_quantity});

  @override
  Widget build(BuildContext context) {

    return  Card(

      child: ListTile(
        contentPadding: EdgeInsets.all(0.0),

        //==========leading secting==============

        leading: Image.asset(card_prod_picture, width: 80.0, height: 80.0,),
        title: Text(card_prod_name, style: TextStyle(fontWeight: FontWeight.bold),),


        subtitle: new Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(0.0),child: Text('Size'),),
              Padding(padding: const EdgeInsets.all(4.0),child: Text(card_prod_size.toString(), style: TextStyle(color: Colors.red),),),

              //=================color section

              Padding(padding: const EdgeInsets.only(left:18.0),child: Text('Color'),),
              Padding(padding: const EdgeInsets.all(4.0),child: Text(card_prod_color, style:  TextStyle(color: Colors.red),),


              ),
            ],
          ),

          //========Product Price
           Container(
             alignment: Alignment.topLeft,
             child: Text("\$${card_prod_price}", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.red ),),
           ),

        ],
        ),

        trailing: Padding(padding: EdgeInsets.only(right: 20),

        child: FittedBox(fit: BoxFit.fitHeight,

          child: new Column(mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            IconButton(icon: Icon(Icons.arrow_drop_up,size: 50,),onPressed: (){},),

            Text(card_prod_quantity.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

             IconButton(icon: Icon(Icons.arrow_drop_down, size: 50,),onPressed: (){},),
            


          ],
        ),
       // contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
      )


      )) );
  }

  void addQuantity (){
  }


}
