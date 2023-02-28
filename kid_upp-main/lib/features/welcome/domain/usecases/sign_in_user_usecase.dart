import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:kid_upp/features/welcome/domain/repositories/firebase_repository.dart';

class SignInUserCase {
  final FirebaseRepository repository;

  SignInUserCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signInUser(userEntity);
  }
}
