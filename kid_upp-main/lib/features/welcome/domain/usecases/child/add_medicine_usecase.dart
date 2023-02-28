import 'package:kid_upp/features/welcome/domain/repositories/firebase_repository.dart';

class AddMedicineUseCase {
  final FirebaseRepository repository;

  AddMedicineUseCase({required this.repository});
  Future<void> call(medicineList, childId) async {
    repository.addMedicine(medicineList, childId);
  }
}
