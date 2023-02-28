import 'package:kid_upp/features/welcome/domain/entities/child/child_entity.dart';
import 'package:kid_upp/features/welcome/domain/repositories/firebase_repository.dart';

class GetChildInfoUseCase {
  final FirebaseRepository repository;

  GetChildInfoUseCase({required this.repository});

  Stream<List<ChildEntity>> call(childId) {
    return repository.getChildInfo(childId);
  }
}
