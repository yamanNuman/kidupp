part of 'add_medicine_cubit.dart';

abstract class AddMedicineState extends Equatable {
  const AddMedicineState();

  @override
  List<Object> get props => [];
}

class AddMedicineInitial extends AddMedicineState {
  @override
  List<Object> get props => [];
}

class AddMedicineLoading extends AddMedicineState {
  @override
  List<Object> get props => [];
}

class AddMedicineLoaded extends AddMedicineState {
  final Map medicineList;

  const AddMedicineLoaded({required this.medicineList});
  @override
  List<Object> get props => [medicineList];
}

class AddMedicineFailure extends AddMedicineState {
  @override
  List<Object> get props => [];
}
