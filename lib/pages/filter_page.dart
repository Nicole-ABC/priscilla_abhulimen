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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Range: $startYear - $endYear", style: TextS,),
                gender == null ? Text("Gender: All", style: TextS) : Text("Gender: $gender", style: TextS)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle TextS = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white
);