import 'package:flutter/material.dart';
import 'package:e_commerce/Provider/userProvider.dart';
import 'package:e_commerce/Pages/home.dart';
import 'package:provider/provider.dart';




class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);
    return user.status==Status.Authenticated ? HomePage(): Center(
      child: CircularProgressIndicator(),
    );
  }
}