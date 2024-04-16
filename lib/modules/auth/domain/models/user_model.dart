import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoImage;

  UserModel(
      {required this.email,
      required this.uid,
      required this.photoImage});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "photoImage": photoImage,
      };

  static userData(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        email: snapshot['email'],
        uid: snapshot['uid'],
        photoImage: snapshot['photoImage']);
  }
}
