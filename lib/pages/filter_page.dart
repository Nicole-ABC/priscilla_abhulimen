import 'package:flutter/material.dart';
import 'package:priscilla_abhulimen/models/filterModel.dart';
import 'package:priscilla_abhulimen/services/filter_services.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<Filter> filterList = new List<Filter>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFilters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => FilterItem(
              endYear: snapshot.data[index].endYear,
              startYear: snapshot.data[index].startYear,
              gender: snapshot.data[index].gender,
              countries: snapshot.data[index].countries,
              colors: snapshot.data[index].colors,
            ));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class FilterItem extends StatelessWidget {
  final int startYear;
  final int endYear;
  final String gender;
  final List<String> countries;
  final List<String> colors;

  FilterItem({
    this.startYear,
    this.endYear,
    this.gender,
    this.countries,
    this.colors
  });

  Text getCountries (){
    String country = countries.join(", ");
    return Text("Countries: $country", style: TextS);
  }

  Text getColors (){
    String color = colors.join(", ");
    return Text("Colors: $color", style: TextS);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: (){
            print("tapped");
          },
          child: Container(
            margin: EdgeInsets.all(8.0),
            height: 150.0,
            width: double.infinity,
            child: Padding(
              padding:  EdgeInsets.only(left: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Range: $startYear - $endYear", style: TextS,),
                  gender == "" ? Text("Gender: all", style: TextS) : Text("Gender: $gender", style: TextS),
                  countries.isEmpty ? Text("Countries: all", style: TextS) : getCountries(),
                  colors.isEmpty ? Text("Colors: all", style: TextS) : getColors()
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).accentColor,
        )
      ],
    );
  }
}

TextStyle TextS = TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.bold,
  color: Colors.black
);