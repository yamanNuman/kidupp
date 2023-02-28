import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kid_upp/features/welcome/domain/entities/class/class_entity.dart';

class ClassModel extends ClassEntity {
  final String? className;
  final List? lessonPlan;
  final String? classId;
  final List? mealMenu;

  const ClassModel({this.classId, this.className, this.lessonPlan, this.mealMenu})
      : super(className: className, lessonPlan: lessonPlan, classId: classId, mealMenu: mealMenu);

  factory ClassModel.fromSnapShot(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return ClassModel(
        className: snapShot['className'],
        classId: snapShot['classId'],
        mealMenu: List.from(snap.get('mealMenu')),
        lessonPlan: List.from(snap.get('lessonPlan')));
  }

  Map<String, dynamic> toJson() =>
      {'className': className, 'lessonPlan': lessonPlan, 'classId': classId, 'mealMenu': mealMenu};
}
