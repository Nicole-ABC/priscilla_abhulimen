import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:priscilla_abhulimen/services/filter_services.dart';

class CarOwnerPage extends StatefulWidget {
  final int startYear;
  final int endYear;
  final String gender;
  final List<String> countries;
  final List<String> colors;

  CarOwnerPage(
      {this.startYear, this.endYear, this.gender, this.countries, this.colors});

  @override
  _CarOwnerPageState createState() => _CarOwnerPageState();
}

class _CarOwnerPageState extends State<CarOwnerPage> {
  final int startYear;
  final int endYear;
  final String gender;
  final List<String> countries;
  final List<String> colors;

  _CarOwnerPageState(
      {this.startYear, this.endYear, this.gender, this.countries, this.colors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: FutureBuilder(
          future: getFilteredCarOwners(widget.startYear, widget.endYear, widget.gender, widget.countries, widget.colors),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Container(height:150.0 ,child: Center(child: Text('Oops, an error has occured.')));
            } else if(!snapshot.hasData){
              return Container(
                height: 150.0,
                child: Center(
                  child: Text(
                    "No data available for this filter",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => Text('got snapshot'),
            );
          },
        ),
        headerSliverBuilder: (context, isOk) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    child: Image.asset(
                  "assets/images/carOwner.jpg",
                  fit: BoxFit.cover,
                )),
                title: Text(
                  'Car Owners: ',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ];
        },
      ),
    );
  }
}
