import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kid_upp/constants/toast_message.dart';
import 'package:dartz/dartz.dart';
import 'package:kid_upp/features/welcome/data/datasources/remote_data_source/remote_data_source.dart';
import 'package:kid_upp/features/welcome/data/models/child/child_model.dart';
import 'package:kid_upp/features/welcome/data/models/class/class_model.dart';
import 'package:kid_upp/features/welcome/domain/entities/child/child_entity.dart';
import 'package:kid_upp/features/welcome/domain/entities/class/class_entity.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/user/user_model.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  // Not yet localization in this class

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firebaseFirestore});

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore
        .collection("users")
        .where("uid", isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapShot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty && user.passWord!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.passWord!);
      } else {}
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toast("User not found");
      } else if (e.code == "wrong-password") {
        toast("Invalid email or password");
      } else if (e.code == "wrong-email") {
        toast("Invalid email or password");
      } else {
        toast("Unexpected error occur");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> updateUser(UserEntity user) {
    throw UnimplementedError();
  }

  //Class Features
  @override
  Stream<List<ClassEntity>> getClassInfo(String classId) {
    final classCollection = firebaseFirestore
        .collection("classes")
        .where("classId", isEqualTo: classId).limit(1);
    
    return classCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ClassModel.fromSnapShot(e)).toList());
  }

  //Child Features

  @override
  Stream<List<ChildEntity>> getChildInfo(String childId) {
    final classCollection = firebaseFirestore
        .collection("children")
        .where("childId", isEqualTo: childId).limit(1);
    
    return classCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ChildModel.fromSnapShot(e)).toList());
  }

  @override
  Future<void> addMedicine(Map medicineList, String childId) async {
    await firebaseFirestore.collection('children').doc(childId).update({
  'medicine': FieldValue.arrayUnion([medicineList])
});
  }
}
