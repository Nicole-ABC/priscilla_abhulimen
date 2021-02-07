import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:priscilla_abhulimen/services/filter_services.dart';

import 'filter_page.dart';

class CarOwnerPage extends StatefulWidget {
  final int startYear;
  final int endYear;
  final String genders;
  final List<String> countries;
  final List<String> colors;

  CarOwnerPage(
      {this.startYear, this.endYear, this.genders, this.countries, this.colors});

  @override
  _CarOwnerPageState createState() => _CarOwnerPageState(
    startYear: startYear,
    endYear: endYear,
    genders: genders,
    countries: countries,
    colors: colors
  );
}

class _CarOwnerPageState extends State<CarOwnerPage> {
  final int startYear;
  final int endYear;
  final String genders;
  final List<String> countries;
  final List<String> colors;

  int resultsCount;

  _CarOwnerPageState(
      {this.startYear, this.endYear, this.genders, this.countries, this.colors});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: NestedScrollView(
          body: FutureBuilder(
            future: getFilteredCarOwners(widget.startYear, widget.endYear, widget.genders, widget.countries, widget.colors),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return Container(height:150.0 ,child: Center(child: Text('Oops, an error has occured.')));
                } else if(snapshot.data.length == 0){
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
                resultsCount = snapshot.data.length;
                return ListView.builder(
                  itemCount: resultsCount,
                  itemBuilder: (context, index) => CarOwnerItem(
                    firstName: snapshot.data[index].firstName,
                    lastName: snapshot.data[index].lastName,
                    email: snapshot.data[index].email,
                    country: snapshot.data[index].country,
                    carModel: snapshot.data[index].carModel,
                    carModelYear: snapshot.data[index].carModelYear,
                    carColor: snapshot.data[index].carColor,
                    gender: snapshot.data[index].gender,
                    jobTitle: snapshot.data[index].jobTitle,
                    bio: snapshot.data[index].bio,
                  )
                );
              }
              else{
                return Center(
                  child: Container(
                    height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text(
                          "Loading...",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                );
              }
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
                    resultsCount != null ? 'Car Owners: $resultsCount results' : 'Car Owners',
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
      ),
    );
  }
}

class CarOwnerItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String carModel;
  final int carModelYear;
  final String carColor;
  final String gender;
  final String jobTitle;
  final String bio;

  CarOwnerItem({
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.carModel,
    this.carModelYear,
    this.carColor,
    this.gender,
    this.jobTitle,
    this.bio
  });

  displayDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Bio"),
          content: new Text("$bio"),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () => displayDialog(context),
          child: Container(
            margin: EdgeInsets.only(left: 8.0),
            height: 200.0,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Full Name: $lastName $firstName",
                    style: TextS,
                  ),
                  Text(
                    "Email: $email",
                    style: TextS,
                  ),
                  Text(
                    "Country: $country",
                    style: TextS,
                  ),
                  Text(
                    "Car Details: $carColor, $carModel, $carModelYear ",
                    style: TextS,
                  ),
                  Text(
                    "Gender: $gender",
                    style: TextS,
                  ),
                  Text(
                    "Job Title: $jobTitle",
                    style: TextS,
                  ),
                  Text(
                    "Bio: $bio",
                    overflow: TextOverflow.ellipsis,
                    style: TextS,
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        'Tap to view bio',
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Divider(
            thickness: 2.0,
            color: Theme.of(context).accentColor,
          ),
        )
      ],
    );
  }
}


