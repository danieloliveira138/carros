import 'package:flutter/material.dart';

nav(context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

pop(context) {
  Navigator.pop(context);
}