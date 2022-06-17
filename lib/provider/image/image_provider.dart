import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workhub/data/model/image.dart';
import 'package:workhub/data/repository/image_reponsitory.dart';
import 'package:workhub/provider/image/image_state.dart';

class ImageApiProvider with ChangeNotifier{
   ImageState _state = ImageState.initial();
   ImageState get state =>_state;
   final ImageRepository imageRepository;
   ImageApiProvider({
      required this.imageRepository
});
  Future<void> getImage() async{
     _state = _state.copyWith(imageStatus: ImageStatus.loading);
     
     try{
        final List<ImageApi>? imageApi = await imageRepository.getImage();
        _state = _state.copyWith(
           imageStatus: ImageStatus.success,
           imageApi: imageApi
        );
        notifyListeners();
     }catch(_){
        _state =_state.copyWith(
           imageStatus: ImageStatus.errors
        );
        notifyListeners();
     }
  }

}