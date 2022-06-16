import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:workhub/value/constants.dart';

import '../model/image.dart';

class ImageRepository{
  final Dio dio = Dio();
  Future<List<ImageApi>?> getImage() async{
    try{
      Response response = await dio.get(Constants.url);
      if(response.statusCode ==200){
        return (response.data as List).map((e) => ImageApi.fromJson(e)).toList();
      }

    }catch(_){

    }
    return null;
  }
  
}