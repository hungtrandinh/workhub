import 'package:cloud_firestore/cloud_firestore.dart';
class MyUser {
  final String? aboutme;
  final String? name;
  final String? email;
  final String? id;
  final String? profilePictureURL;

  const MyUser(
      {this.profilePictureURL,
        this.name,
        this.aboutme,
        this.email,
        required this.id});
  static const empty = MyUser(id: '');
  bool get isEmpty => this == MyUser.empty;
  bool get isNotEmpty => this != MyUser.empty;

  @override
  List<Object?> get props => [name, email, id];
  Map<String, dynamic> toDocument() {
    return {
      'username': name,
      'email': email,
      'imageUrl': profilePictureURL,
    };
  }

  factory MyUser.fromDocument(DocumentSnapshot doc) {
    String? profilePictureURL = null;
    String gmail = "tdhung.18it4";
    String nickname = "hung";
    return MyUser(
      id: doc.id,
      email: doc["email"] ?? gmail,
      name: doc["firstName"] ?? nickname,
      profilePictureURL: doc["profilePictureURL"] ?? profilePictureURL,
    );
  }

  static MyUser fromJson(Map<String, dynamic> parsedJson) {
    return MyUser(
      email: parsedJson['email'] ?? '',
      name: parsedJson['firstName'] ?? '',
      id: parsedJson['id'] ?? parsedJson['userID'] ?? '',
      profilePictureURL: parsedJson['profilePictureURL'] ?? null,
    );
  }

  MyUser copyWith(
      {int? following,
        int? followers,
        String? email,
        String? aboutme,
        String? name,
        String? id,
        String? profilePictureURL}) {
    return MyUser(

        aboutme: aboutme ?? this.aboutme,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        profilePictureURL: profilePictureURL ?? this.profilePictureURL);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email ?? " hung",
      'firstName': name ?? "Tron Minh Hang",
      'id': id ?? "123",
      'profilePictureURL': profilePictureURL ,
    };
  }
}