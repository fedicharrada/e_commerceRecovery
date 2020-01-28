
 import 'package:flutter/material.dart';
 import 'package:e_commerce/Pages/product_detail.dart';

class Products extends StatefulWidget{

  @override
 ProductState createState()=> ProductState();

}



class ProductState extends State<Products>{
  var Product_List=[
    {
      "name":"blazer1",
      "picture":"images/products/blazer1.jpeg",
      "Old price":120,
      "price":58,
    },


    {
      "name":"blazer2",
      "picture":"images/products/blazer2.jpeg",
      "Old price":170,
      "price":88,
    },


    {
      "name":"dress",
      "picture":"images/products/dress1.jpeg",
      "Old price":170,
      "price":88,
    },

    {
      "name":"dress2",
      "picture":"images/products/dress2.jpeg",
      "Old price":190,
      "price":98,
    },


    {
      "name":"hills",
      "picture":"images/products/hills1.jpeg",
      "Old price":100,
      "price":78,
    },

    {
      "name":"hills2",
      "picture":"images/products/hills2.jpeg",
      "Old price":130,
      "price":88,
    }

  ];




  @override
  Widget build(BuildContext context){
    return GridView.builder(
      itemCount: Product_List.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext, int index){
          return Single_prod(
            product_name: Product_List[index]["name"],
            product_picture: Product_List[index]["picture"],
            prod_old_price:  Product_List[index]["Old price"],
            prod_price: Product_List[index]["price"],
          );
        });

  }
}



class Single_prod extends StatelessWidget{

  final product_name;
  final product_picture;
  final prod_old_price;
  final prod_price;

  Single_prod({this.product_name, this.product_picture, this.prod_old_price, this.prod_price});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Hero(tag: product_name, child: Material(
        child: InkWell(
          onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>new ProductDetail(
              product_detai_name:product_name,
            product_detai_new_price: prod_price,
            product_detai_old_price: prod_old_price,
            product_detai_picture: product_picture,
          ))),
          child: GridTile(
            footer: Container(
              height: 60,
              color: Colors.white70,
              child: ListTile(
                leading: Text(product_name, style: TextStyle(fontWeight: FontWeight.bold),),
             title: Text('\$${prod_price.toString()}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
             subtitle: Text('\$${prod_old_price.toString()}', style: TextStyle(fontWeight: FontWeight.bold)), ),
            ),
            child: Image.asset(product_picture, fit: BoxFit.cover,) ,
          ),
        ) ,
        ),
      ),

    );
  }



}