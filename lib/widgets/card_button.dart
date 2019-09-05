import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardButton extends StatelessWidget {

  Function action;
  String title;

  CardButton({this.action, this.title});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(title),
      onPressed: () => action(),
    );
  }
}
