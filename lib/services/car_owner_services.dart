import 'dart:io';
import 'dart:async';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:priscilla_abhulimen/models/carOwnerModel.dart';

List<CarOwner> carOwnersList = new List<CarOwner>();

csvToList(String path) async{
  final myData = await rootBundle.loadString(path);
  List<List<dynamic>> csvList = CsvToListConverter().convert(myData);
  for(int i=1; i<csvList.length; i++){
    carOwnersList.add(
      CarOwner(
        id: csvList[i][0],
        firstName: csvList[i][1],
        lastName:csvList[i][2],
        email: csvList[i][3],
        country: csvList[i][4],
        carModel: csvList[i][5],
        carModelYear: csvList[i][6],
        carColor: csvList[i][7],
        gender: csvList[i][8],
        jobTitle: csvList[i][9],
        bio: csvList[i][10],
      )
    );
  }
  print(carOwnersList.length);
}