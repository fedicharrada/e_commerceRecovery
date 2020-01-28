
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:e_commerce/Pages/home.dart';


class ProductDetail extends StatefulWidget{

  final product_detai_name;
  final product_detai_new_price;
  final product_detai_old_price;
  final product_detai_picture;

  ProductDetail({
    this.product_detai_name,
    this.product_detai_new_price,
    this.product_detai_old_price,
    this.product_detai_picture
  });




  @override
  _ProductDetail createState() =>_ProductDetail();

}

class _ProductDetail extends State<ProductDetail>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.red,
          title: InkWell(onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>new HomePage())),
            child:Center(
              child: Text('Product Details', style: TextStyle(color: Colors.white),),),),
          actions: <Widget>[

          ],
        ),

      body: ListView(
        children: <Widget>[



      Container(
        width: MediaQuery.of(context).size.width,
        height: 300.0,
        child: GridTile(
          child: Container(
            color:Colors.white70,
            child: Image.asset(widget.product_detai_picture),
          ),
          footer: Container(
            color: Colors.white,
            child: ListTile(
              leading: Text(widget.product_detai_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), ),
              title: new Row(
                children: <Widget>[
                  Expanded(
                    child:Text('\$${widget.product_detai_old_price.toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, decoration: TextDecoration.lineThrough, color: Colors.grey), ),
                  ),
                  Expanded(
                    child:Text('\$${widget.product_detai_new_price.toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
         //  ============= Size Button

          Row(
            children: <Widget>[
              Expanded( child: MaterialButton(
                elevation: 0.2,
                onPressed: (){ showDialog(context: context,
                builder: (context){return new AlertDialog(
                  title: Text('Size'),
                  content: new Text("Choose the size"),
                  actions: <Widget>[
                    new MaterialButton(onPressed: (){Navigator.pop(context);},
                    child: Text('Close'),),

                  ],

                );}); },


                color: Colors.white,
                textColor: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("Size"),),
                    Expanded(child: new Icon(Icons.arrow_drop_down),)
                  ],
                ),
              ),),



              Expanded( child: MaterialButton(
                onPressed: (){ showDialog(context: context,
                    builder: (context){return new AlertDialog(
                      title: Text('Color'),
                      content: new Text("Choose the Requested Color"),
                      actions: <Widget>[
                        new MaterialButton(onPressed: (){Navigator.pop(context);},
                          child: Text('Close'),),

                      ],

                    );}); },

                elevation: 0.2,
                color: Colors.white,
                textColor: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("Color"),),
                    Expanded(child: new Icon(Icons.arrow_drop_down),)
                  ],
                ),
              ),),



              Expanded( child: MaterialButton(
                elevation: 0.2,
                onPressed: (){ showDialog(context: context,
                    builder: (context){return new AlertDialog(
                      title: Text('Quantity'),
                      content: new Text("Choose the Requested Quantity"),
                      actions: <Widget>[
                        new MaterialButton(onPressed: (){Navigator.pop(context);},
                          child: Text('Close'),),

                      ],

                    );}); },

                color: Colors.white,
                textColor: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("Qty"),),
                    Expanded(child: new Icon(Icons.arrow_drop_down),)
                  ],
                ),
              ),),



            ],
          ),

          // ==============the second button=========

          Row(
            children: <Widget>[

              Expanded( child: MaterialButton(
                elevation: 0.2,
                onPressed: (){},
                color: Colors.red,
                textColor: Colors.white,

                    child: Text("Buy Now"),


              ),),

              new IconButton(icon: Icon(Icons.add_shopping_cart, color: Colors.red,)),
              new IconButton(icon: Icon(Icons.favorite_border, color: Colors.red,))
            ],
          ),


          Divider(),

          new ListTile(
            title: Text('Product detauls'),
            subtitle: new Text('Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de  depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte Il  pas fait que survivre cinq siècles, mais s '),
          ),


          Divider(),
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              child: Text('Product name', style:  TextStyle(color: Colors.grey),),),
            Padding(padding: EdgeInsets.all(5.0),
            child: Text(widget.product_detai_name),)
            ],
          ),

              ////////////product Brand
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text('Product Brand', style:  TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: Text('Product Brand'),)
            ],
          ),

             //////////////Product condition

          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text('Product condition', style:  TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: Text('New Or Used'),)
            ],
          ),
          Divider(),
          Padding(padding: const EdgeInsets.all(8.0),
          child: Text('Similar Product'),),


          ////    Similar Section
          Container(
            height: 360.0,
            child: SimilarProduct(),
          )



        ],
      )
    );

  }

}




//==================Similar Product
class SimilarProduct extends StatefulWidget {
  @override
  Similar createState() =>Similar();

}
class Similar extends State<SimilarProduct>{
  var Product_List=[
    {
      "name":"blazer1",
      "picture": "images/products/blazer1.jpeg",
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