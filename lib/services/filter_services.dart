import 'package:dio/dio.dart';
import 'dart:async';
import 'package:priscilla_abhulimen/models/filterModel.dart';
import 'dart:io';

String url = "https://run.mocky.io/v3/b4cdeed3-327b-4591-9b06-aaf043e65497";

Future<List<Filter>> getFilters() async{
  try{
    var response = await Dio().get(url);
    // print (response.data);
    return filterFromJson(response.data);
  }
  catch(e){
    print(e);
  }

}