import 'package:dio/dio.dart';
import 'package:priscilla_abhulimen/models/car_owner_model.dart';
import 'dart:async';
import 'package:priscilla_abhulimen/models/filter_model.dart';
import 'package:priscilla_abhulimen/services/car_owner_services.dart';

String url = "https://run.mocky.io/v3/b4cdeed3-327b-4591-9b06-aaf043e65497";

Future<List<Filter>> getFilters() async {
  try {
    var response = await Dio().get(url);
    return filterFromJson(response.data);
  }
  catch (e) {
    print(e);
  }
}

Future<List<CarOwner>> getFilteredCarOwners(int startYear, int endYear,
    String gender, List<String> countries, List<String> colors) async {
  List<CarOwner> carOwnersList = await csvToList();
  List<CarOwner> filteredCarOwnerList = [];
  CarOwner carOwner = CarOwner();


  for(int i=0; i<carOwnersList.length; i++){
    carOwner = carOwnersList[i];

    if(carOwner.carModelYear >= startYear && carOwner.carModelYear <= endYear){
      if(gender != "" && carOwner.gender.toLowerCase() == gender){
        if(countries.isNotEmpty){
          for(int j=0; j<countries.length; j++){
            if(countries[j] == carOwner.country){
              if(colors.isNotEmpty) {
                for (int k = 0; k < colors.length; k++) {
                  if (colors[k] == carOwner.carColor) {
                    filteredCarOwnerList.add(carOwner);
                  }
                }
              }
              else{
                filteredCarOwnerList.add(carOwner);
              }
            }
          }
        }
        else if(countries.isEmpty && colors.isNotEmpty){
          for(int k=0; k<colors.length; k++){
            if(colors[k] == carOwner.carColor){
              filteredCarOwnerList.add(carOwner);
            }
          }
        }
        else if(colors.isEmpty){
          filteredCarOwnerList.add(carOwner);
        }
      }
      else if(gender == ""){
        if(countries.isNotEmpty){
          for(int j=0; j<countries.length; j++){
            if(countries[j] == carOwner.country){
              if(colors.isNotEmpty){
                for(int k=0; k<colors.length; k++){
                  if(colors[k] == carOwner.carColor){
                    filteredCarOwnerList.add(carOwner);
                  }

                }
              }

            }
            else if(colors.isNotEmpty){
              for(int k=0; k<colors.length; k++){
                if(colors[k] == carOwner.carColor){
                  filteredCarOwnerList.add(carOwner);
                }
              }
            }
          }
        }
        else if(colors.isNotEmpty){
            for(int k=0; k<colors.length; k++){
              if(colors[k] == carOwner.carColor){
                filteredCarOwnerList.add(carOwner);

              }
            }
          }


      }

    }

  }
  return filteredCarOwnerList;
}
