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

// for every value in the carOwnerList,
  for(int i=0; i<carOwnersList.length; i++){
    carOwner = carOwnersList[i];
// if statement is true if carModelYear falls within the range in the filter
    if(carOwner.carModelYear >= startYear && carOwner.carModelYear <= endYear){
      /* if it is true check if gender is an empty string and lowercase
      value of carOwner.gender equals gender from filter else if gender is
      empty carOwner is moved to the next filter else do nothing
      and restart loop with new carOwner
       */
      if(gender != "" && carOwner.gender.toLowerCase() == gender){
        // if true check if countries is empty
        if(countries.isNotEmpty){
          //if true for every country compare value of carOwner.country else if it is empty carOwner is moved to the next filter
          for(int j=0; j<countries.length; j++){
            if(countries[j] == carOwner.country){
              // if country is equal to carOwner.country, compare values of colors from color list else do nothing
              if(colors.isNotEmpty) {
                //if true for every color compare value of carOwner.color else if it is empty add car owner to filtered list
                for (int k = 0; k < colors.length; k++) {
                  if (colors[k] == carOwner.carColor) {
                    //if true, add carOwner to filtered list
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
  //return filtered list
  return filteredCarOwnerList;
}
