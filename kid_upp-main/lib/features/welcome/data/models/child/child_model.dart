import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kid_upp/features/welcome/domain/entities/child/child_entity.dart';

class ChildModel extends ChildEntity {
  final String? childID;
  final String? childName;
  final Map? classInfo;
  final List? medicineList;

  const ChildModel(
      {this.childID, this.childName, this.classInfo, this.medicineList})
      : super(
            childID: childID,
            childName: childName,
            classInfo: classInfo,
            medicineList: medicineList);

  factory ChildModel.fromSnapShot(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return ChildModel(
      childID: snapShot['childId'],
      childName: snapShot['ChildName'],
      classInfo: Map.from(snap.get('classInfo')),
      medicineList: List.from(snap.get('medicine'))
      );
  }

  Map<String, dynamic> toJson() =>
      {'childId': childID, 'ChildName': childName, 'classInfo': classInfo, 'medicine': medicineList};
}
