class ImageApi {
  final String id;
  final String author;
  final String download_url;

  ImageApi({required this.id, required this.author, required this.download_url});
  factory ImageApi.initial(){
    return ImageApi(id:"", author: "", download_url: "");
  }

  factory ImageApi.fromJson(Map<String, dynamic> json) {
    return ImageApi(id: json["id"], author: json["author"], download_url: json["download_url"]);
  }
}
