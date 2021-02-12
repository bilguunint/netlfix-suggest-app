import 'package:flutter/material.dart';

class CardFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.grey[400],
                ),
                child: Center(
                  child: Image.asset("assets/img/netflix_logo.png"),
                ),
              );
  }
}