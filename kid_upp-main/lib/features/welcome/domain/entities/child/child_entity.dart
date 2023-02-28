import 'package:equatable/equatable.dart';

class ChildEntity extends Equatable {
  final String? childID;
  final String? childName;
  final Map? classInfo;
  final List? medicineList;

  const ChildEntity(
      {this.childID, this.childName, this.classInfo, this.medicineList});

  @override
  List<Object?> get props => [childID, childName, classInfo, medicineList];
}
