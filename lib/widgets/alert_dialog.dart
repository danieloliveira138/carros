import 'package:flutter/material.dart';

alertDialog(BuildContext context, String title, String message, {Function cancel, Function ok}) {

  Widget _okButton, _cancelButton;
  ListView<Widget> _buttons = [] as ListView;

  if(ok != null) {
    _buttons.add(
        FlatButton(
            child: Text('OK'),
            onPressed: ok
        )
    );
  }

  if (cancel != null) {
    _buttons.add(
        FlatButton(
            onPressed: cancel,
            child: Text('Cancelar')
        )
    );
  }

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: ListView<Widget> = [

          ]
        );
      }
  );
}