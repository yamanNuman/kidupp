//all the data of the users
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? userName;
  final String? phone;
  final String? email;
  final String? passWord;
  final List? childrenName;
  
  const UserEntity({this.phone, this.email, this.childrenName, this.uid, this.userName, this.passWord});

  @override
  List<Object?> get props => [uid, userName, passWord, childrenName, phone, email];
}
