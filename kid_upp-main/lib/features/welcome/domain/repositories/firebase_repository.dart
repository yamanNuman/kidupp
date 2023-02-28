import 'package:dartz/dartz.dart';
import 'package:kid_upp/features/welcome/domain/entities/child/child_entity.dart';
import 'package:kid_upp/features/welcome/domain/entities/class/class_entity.dart';
import '../entities/user/user_entity.dart';

abstract class FirebaseRepository {
  //Credential Features
  Future<void> signInUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  //User Features

  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> updateUser(UserEntity user);

  //Class Features

  Stream<List<ClassEntity>> getClassInfo(String classId);

  //Child Features
  Stream<List<ChildEntity>> getChildInfo(String childId);
  Future<void> addMedicine(Map medicineList, String childId);
}
