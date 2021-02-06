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
    print(countries);
    String country = countries.join(", ");
    return Text("Countries: $country", style: TextS);
  }

  Text getColors (){
    print(colors);
    String color = colors.join(", ");
    return Text("Colors: $color", style: TextS);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: GestureDetector(
        child: Card(
          child: Padding(
            padding:  EdgeInsets.only(left: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Range: $startYear - $endYear", style: TextS,),
                gender == null ? Text("Gender: all", style: TextS) : Text("Gender: $gender", style: TextS),
                countries.isEmpty ? Text("Countries: all", style: TextS) : getCountries(),
                colors.isEmpty ? Text("Colors: all", style: TextS) : getColors()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle TextS = TextStyle(
  fontSize: 10.0,
  fontWeight: FontWeight.bold,
  color: Colors.black
);