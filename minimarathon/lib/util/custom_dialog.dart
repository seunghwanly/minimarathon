import 'package:flutter/material.dart';
import 'package:minimarathon/util/palette.dart';

showMyDialog(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
          elevation: 16.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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

customAlertAsync({BuildContext context, final function}) {
  return showDialog(
                      context: context,
                      child: new Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        backgroundColor: white,
                        elevation: 16.0,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          padding: EdgeInsets.all(10.0),
                          child: 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Hope Sharing Relay",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      textAlign: TextAlign.center),
                                  Text("Would you like to log out?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FlatButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: superlight,
                                    child: Text("Cancel",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                        textAlign: TextAlign.center),
                                  ),
                                  FlatButton(
                                    onPressed: function,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: mandarin,
                                    child: Text("OK",
                                        style: TextStyle(
                                            color: white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                        textAlign: TextAlign.center),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                      ));
}