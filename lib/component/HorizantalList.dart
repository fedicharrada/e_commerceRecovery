
import 'package:flutter/foundation.dart';
import'package:flutter/material.dart';


class HorizontalList extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[

          Category(
            image_caption: 'Accessoires',
            image_location: 'images/cats/accessories.png',),

          Category(
            image_caption: 'Dress',
            image_location: 'images/cats/dress.png',),


          Category(
            image_caption: 'Formal',
            image_location: 'images/cats/formal.png',),


          Category(
            image_caption: 'Informal',
            image_location: 'images/cats/informal.png',),





          Category(
            image_caption: 'Jeans',
            image_location: 'images/cats/jeans.png',),



          Category(
            image_caption: 'Shoes',
            image_location: 'images/cats/shoe.png'),



          Category(
              image_caption: 'T-shirt',
              image_location: 'images/cats/tshirt.png'),








        ],

      ),
    );
  }

}



 class Category extends StatelessWidget{
  String image_location;
  String image_caption;
  Category({this.image_location, this.image_caption});


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(onTap: (){},
          child: Container(
            width: 100.0,


      child: ListTile(
        title: Image.asset(image_location, width: 60.0, height: 40.0,),
        subtitle:Container(
          height: 20,
          alignment: Alignment.center,
        child:Text(image_caption, style: TextStyle(fontSize: 15.0)),
        ),
      )),),

    );

}


}
