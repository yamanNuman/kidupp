import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:kid_upp/features/welcome/data/datasources/remote_data_source/remote_data_source.dart';
import 'package:kid_upp/features/welcome/data/datasources/remote_data_source/remote_data_source_impl.dart';
import 'package:kid_upp/features/welcome/data/repositories/firebase_repository_impl.dart';
import 'package:kid_upp/features/welcome/domain/repositories/firebase_repository.dart';
import 'package:kid_upp/features/welcome/domain/usecases/child/add_medicine_usecase.dart';
import 'package:kid_upp/features/welcome/domain/usecases/class/get_class_info_usecase.dart';
import 'package:kid_upp/features/welcome/domain/usecases/user/get_current_uid_usecase.dart';
import 'package:kid_upp/features/welcome/domain/usecases/user/get_single_user_usecase.dart';
import 'package:kid_upp/features/welcome/domain/usecases/user/is_sign_in_usecase.dart';
import 'package:kid_upp/features/welcome/domain/usecases/user/sign_in_user_usecase.dart';
import 'package:kid_upp/features/welcome/domain/usecases/user/sign_out_usecase.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/auth/auth_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/child/cubit/add_medicine_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/class/get_class_info_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/credential/credential_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/get_single_user/get_single_user_cubit.dart';

import 'features/welcome/domain/usecases/child/get_child_info_usecase.dart';
import 'features/welcome/presentation/cubit/child/get_child_info/get_child_info_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Cubit
  sl.registerFactory(() => AuthCubit(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));
  sl.registerFactory(() => CredentialCubit(signInUserCase: sl.call()));
  sl.registerFactory(() => GetSingleUserCubit(getSingleUserUseCase: sl.call()));
  sl.registerFactory(() => GetClassInfoCubit(getClassInfoUseCase: sl.call()));
  sl.registerFactory(() => GetChildInfoCubit(getChildInfoUseCase: sl.call()));
  
  
  sl.registerLazySingleton(() => AddMedicineCubit(addMedicineUseCase: sl.call()));

  /// Usecases
  sl.registerLazySingleton(() => SignInUserCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetClassInfoUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetChildInfoUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => AddMedicineUseCase(repository: sl.call()));

  /// Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  /// Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          firebaseAuth: sl.call(), firebaseFirestore: sl.call()));

  ///Language

  /// Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
}
