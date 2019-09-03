import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {

  String title;
  Function onPressed;

  AppButton(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.blueAccent,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
