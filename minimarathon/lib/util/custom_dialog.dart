import 'package:flutter/material.dart';
import 'package:minimarathon/util/palette.dart';

showMyDialog(BuildContext context, String str) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        backgroundColor: white,
        elevation: 16.0,
        child: Container(
            height: MediaQuery.of(context).size.height / 4,
            padding: EdgeInsets.all(10.0),
            child: Column(
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
                      Text(str,
                          style: TextStyle(
                              color: Colors.black54,
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
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
      );
    },
  );
}

customAlert({BuildContext context, final function, String str}) {
  return showDialog(
      context: context,
      child: new Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        backgroundColor: white,
        elevation: 16.0,
        child: Container(
            height: MediaQuery.of(context).size.height / 4,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Hope Sharing Relay",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center),
                      Text(str,
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
                            borderRadius: BorderRadius.circular(30.0)),
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
                            borderRadius: BorderRadius.circular(30.0)),
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

customAlertRichText({BuildContext context, final function, RichText richText}) {
  return showDialog(
      context: context,
      child: new Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        backgroundColor: white,
        elevation: 16.0,
        child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: MediaQuery.of(context).size.width / 10,
                        color: deepPastelblue,
                      ),
                      Text("Enable location\n",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                          textAlign: TextAlign.center),
                      richText
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
                            borderRadius: BorderRadius.circular(30.0)),
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
                            borderRadius: BorderRadius.circular(30.0)),
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
                ),
              ],
            )),
      ));
}
