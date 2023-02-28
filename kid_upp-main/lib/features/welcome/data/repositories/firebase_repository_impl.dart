import 'package:kid_upp/features/welcome/data/datasources/remote_data_source/remote_data_source.dart';
import 'package:kid_upp/features/welcome/domain/entities/child/child_entity.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:kid_upp/features/welcome/domain/repositories/firebase_repository.dart';
import '../../domain/entities/class/class_entity.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  //Be careful. Don't use async-await with stream
  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      remoteDataSource.getSingleUser(uid);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async =>
      remoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> updateUser(UserEntity user) async =>
      remoteDataSource.updateUser(user);

//Class Features
  @override
  Stream<List<ClassEntity>> getClassInfo(String classId) =>
      remoteDataSource.getClassInfo(classId);

  @override
  Stream<List<ChildEntity>> getChildInfo(String childId) =>
      remoteDataSource.getChildInfo(childId);

  @override
  Future<void> addMedicine(Map medicineList, String childId) async {
    remoteDataSource.addMedicine(medicineList, childId);
  }
}
