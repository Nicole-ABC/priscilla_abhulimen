import 'package:flutter/material.dart';
import 'package:priscilla_abhulimen/pages/filter_page.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget{
  //root of the app
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF7ECBE4),
          accentColor: Color(0xFFE5E5E5)
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Filters"),
      ),
      body: FilterPage(),
      // new ListView.builder(
      //     itemCount: 1,
      //     itemBuilder: (BuildContext context, int index){
      //       return new Container(
      //         child: new Center(
      //           child: new Column(
      //             crossAxisAlignment:  CrossAxisAlignment.stretch,
      //             children: <Widget>[
      //               new Card(
      //                 child: new Container(
      //                   child: new Text("Hello"),
      //                   padding: const EdgeInsets.all(20.0),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      // ),
    );
  }
}
