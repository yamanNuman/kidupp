import 'package:kid_upp/features/welcome/domain/repositories/firebase_repository.dart';

import '../../entities/user/user_entity.dart';

class GetSingleUserUseCase {
  final FirebaseRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }
}
