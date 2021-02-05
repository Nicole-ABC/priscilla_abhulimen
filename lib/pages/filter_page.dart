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
            itemBuilder: (context, index) => Text("${snapshot.data[index].id}"),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

