part of 'get_child_info_cubit.dart';

abstract class GetChildInfoState extends Equatable {
  const GetChildInfoState();

  @override
  List<Object> get props => [];
}

class GetChildInfoInitial extends GetChildInfoState {
  @override
  List<Object> get props => [];
}

class GetChildInfoLoading extends GetChildInfoState {
  @override
  List<Object> get props => [];
}

class GetChildInfoLoaded extends GetChildInfoState {
  final ChildEntity childInfo;

  const GetChildInfoLoaded({required this.childInfo});
  @override
  List<Object> get props => [childInfo];
}

class GetChildInfoFailure extends GetChildInfoState {
  @override
  List<Object> get props => [];
}