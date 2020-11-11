import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("Hello World"),
        ),
        body: new Center(child: MyHomePage(),)
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text('2020 Hope Sharing Relay'),
                Text("Let's Run & Share")
              ],
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  TextField(
                    
                  ),
                  FlatButton(
                    color: Colors.amberAccent,
                    onPressed: () {},
                    child: Container(
                      child: Text('A'),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  FlatButton(
                    color: Colors.amberAccent,
                    onPressed: () {},
                    child: Container(
                      child: Text('A'),
                    ),
                  ),
                  FlatButton(
                    color: Colors.amberAccent,
                    onPressed: () {},
                    child: Container(
                      child: Text('A'),
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
