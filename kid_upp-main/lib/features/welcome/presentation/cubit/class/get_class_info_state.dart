part of 'get_class_info_cubit.dart';

abstract class GetClassInfoState extends Equatable {
  const GetClassInfoState();

  @override
  List<Object> get props => [];
}

class GetClassInfoInitial extends GetClassInfoState {
  @override
  List<Object> get props => [];
}

class GetClassInfoLoading extends GetClassInfoState {
  @override
  List<Object> get props => [];
}

class GetClassInfoLoaded extends GetClassInfoState {
  final ClassEntity classInfo;

  const GetClassInfoLoaded({required this.classInfo});
  @override
  List<Object> get props => [classInfo];
}

class GetClassInfoFailure extends GetClassInfoState {
  @override
  List<Object> get props => [];
}
