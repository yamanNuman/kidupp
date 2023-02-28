import 'package:equatable/equatable.dart';

class ClassEntity extends Equatable {
  final String? className;
  final List? lessonPlan;
  final String? classId;
  final List? mealMenu;

  const ClassEntity({this.mealMenu, this.classId, this.className, this.lessonPlan});

  @override
  List<Object?> get props => [className, lessonPlan, classId, mealMenu];
}
