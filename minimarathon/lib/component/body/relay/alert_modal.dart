import 'package:flutter/material.dart';

Widget showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('End Relay'),
        content: Text("Are You Sure Want To Finish ?"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "YES",
              style: TextStyle(),
            ),
            onPressed: () {
              //Put your code here which you want to execute on Yes button click.
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("NO"),
            onPressed: () {
              //Put your code here which you want to execute on No button click.
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              //Put your code here which you want to execute on Cancel button click.
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
