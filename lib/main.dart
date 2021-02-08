import 'package:flutter/material.dart';
import 'package:priscilla_abhulimen/pages/filter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //root of the app
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Priscilla Abhulimen',
      home: new HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF202020), accentColor: Color(0xFFE5E5E5)),
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
        body: Scrollbar(
          child: NestedScrollView(
      body: FilterPage(),
      headerSliverBuilder: (context, isOk) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/car.jpg",
                  fit: BoxFit.cover,
                ),
                title: Text(
                  'Select a Filter: ',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ];
      },
    ),
        ));
  }
}
