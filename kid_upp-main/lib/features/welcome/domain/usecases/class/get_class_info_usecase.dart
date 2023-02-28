import 'package:kid_upp/features/welcome/domain/entities/class/class_entity.dart';
import 'package:kid_upp/features/welcome/domain/repositories/firebase_repository.dart';

class GetClassInfoUseCase {
  final FirebaseRepository repository;

  GetClassInfoUseCase({required this.repository});

  Stream<List<ClassEntity>> call(classId) {
    return repository.getClassInfo(classId);
  }
}
