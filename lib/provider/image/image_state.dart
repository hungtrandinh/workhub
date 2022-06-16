
import 'package:equatable/equatable.dart';
import 'package:workhub/data/model/image.dart';


enum ImageStatus{
  initial,
  loading,
  success,
  errors
}
class ImageState extends Equatable{
  final List<ImageApi>? imageApi;
  final ImageStatus imageStatus;
  const ImageState({
    required this.imageApi,
    required this.imageStatus
});
  factory ImageState.initial(){
    return const ImageState(imageApi:null , imageStatus: ImageStatus.initial);
  }
  ImageState copyWith({
 List<ImageApi>? imageApi,
  ImageStatus? imageStatus
}){
    return ImageState(imageApi: imageApi ?? this.imageApi, imageStatus: this.imageStatus);
  }
  @override
  List<Object?> get props => [imageStatus,imageApi];

}