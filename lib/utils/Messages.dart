import 'package:flutter/material.dart';

class Messages {
  void msgErro(String msg, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Erro"),
              backgroundColor: Colors.green,
              content: new Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
