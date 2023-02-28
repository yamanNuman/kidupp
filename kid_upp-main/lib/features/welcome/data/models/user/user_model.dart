import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? userName;
  final String? phone;
  final String? email;
  final List? childrenName;
  

  const UserModel(
      {this.phone,
      this.email,
      this.uid,
      this.userName,
      this.childrenName,
      })
      : super(
            uid: uid,
            userName: userName,
            childrenName: childrenName,           
            phone: phone,
            email: email);

  factory UserModel.fromSnapShot(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return UserModel(
        uid: snapShot['uid'],
        userName: snapShot['userName'],
        childrenName: List.from(snap.get("childrenName")),
        phone: snapShot['phone'],
        email: snapShot['email']);
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "userName": userName,
    "childrenName":childrenName,
    "phone": phone,
    "email": email

  };
}
