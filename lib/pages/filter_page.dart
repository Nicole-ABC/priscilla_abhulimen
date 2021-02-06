import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:priscilla_abhulimen/models/filterModel.dart';
import 'package:priscilla_abhulimen/services/car_owner_services.dart';
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

class FilterItem extends StatefulWidget {
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
  @override
  _FilterItemState createState() => _FilterItemState(
    startYear: startYear,
    endYear: endYear,
    gender: gender,
    colors: colors,
    countries: countries
  );
}

class _FilterItemState extends State<FilterItem> {
  final int startYear;
  final int endYear;
  final String gender;
  final List<String> countries;
  final List<String> colors;

  String _localPath;

  _FilterItemState({
    this.startYear,
    this.endYear,
    this.gender,
    this.countries,
    this.colors
  });

  void checkStatus() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      checkPathForFile();
    }
    else{
      print("no permission");
    }
  }

  Future<String> _findLocalPath() async {
    final dir = await getExternalStorageDirectory();
    return dir.path;
  }

  Future<String> checkPathForFile() async {
    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'ehealth';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();

    if (!hasExisted) {
      savedDir.create();
      final id = await FlutterDownloader.enqueue(
          url: "https://drive.google.com/u/0/uc?id=1U_f0t_Yplz1DrExIdIA-YuWYRJiVBare&export=download",
          savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true,
      );
      return savedDir.path;
    }
    else {
      return savedDir.path;
    }
  }

  int progress = 0;
  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    checkStatus();
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloadingCsv");

    receivePort.listen((message) {
      setState(() {
        progress = message;
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  static downloadCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloadingCsv");
    sendPort.send(progress);
  }

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
            checkStatus();

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