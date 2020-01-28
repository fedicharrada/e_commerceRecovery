

    import 'package:flutter/cupertino.dart';
    import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';


    Widget myCarousel() {

      Widget image_carousel = new Container(
        height: 250.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('images/c1.jpg'),
            AssetImage('images/m1.jpeg'),
            AssetImage('images/m2.jpg'),
            AssetImage('images/w1.jpeg'),
            AssetImage('images/w3.jpeg'),
            AssetImage('images/w4.jpeg'),
          ],
          autoplay: true,
         animationCurve: Curves.fastOutSlowIn,
         animationDuration: Duration(milliseconds: 1200),
          dotSize: 4.0,
          dotBgColor: Colors.transparent,
          indicatorBgPadding: 6.0,
          dotColor: Colors.grey ,

        ),
      );
      return image_carousel;
    }