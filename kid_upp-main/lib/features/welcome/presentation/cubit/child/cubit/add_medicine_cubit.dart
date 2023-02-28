import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kid_upp/features/welcome/domain/usecases/child/add_medicine_usecase.dart';

part 'add_medicine_state.dart';

class AddMedicineCubit extends Cubit<AddMedicineState> {
  final AddMedicineUseCase addMedicineUseCase;
  AddMedicineCubit({required this.addMedicineUseCase})
      : super(AddMedicineInitial());

  Future<void> addMedicine(
      {required Map medicineList, required String childId}) async {
    try {
      await addMedicineUseCase.call(medicineList, childId);
    } on SocketException catch (_) {
      emit(AddMedicineFailure());
    } catch (_) {
      emit(AddMedicineFailure());
    }
  }
}
