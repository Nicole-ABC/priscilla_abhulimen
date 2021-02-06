import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:priscilla_abhulimen/pages/filter_page.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  //root of the app
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF101010),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: FilterPage(),
        headerSliverBuilder: (context, isOk){
          return <Widget>[
          SliverAppBar(
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset("assets/images/car.jpg", fit: BoxFit.cover,),
                  title: Text(
                    'Select a Filter: ',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                ),
              ),
          ];
        },
      )
    );
  }
}
