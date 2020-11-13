import 'package:flutter/material.dart';
import 'package:minimarathon/util/palette.dart';

showMyDialog(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
          elevation: 16.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: darkgrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(flex: 2, child: Divider()),
                Expanded(
                  flex: 2,
                  child: Container(
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                              color: Colors.blue[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      )),
                ),
              ],
            ),
          ));
    },
  );
}
