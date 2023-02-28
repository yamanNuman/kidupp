import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kid_upp/features/welcome/domain/entities/class/class_entity.dart';
import 'package:kid_upp/features/welcome/domain/usecases/class/get_class_info_usecase.dart';
import 'package:kid_upp/features/welcome/domain/usecases/user/get_current_uid_usecase.dart';

part 'get_class_info_state.dart';

class GetClassInfoCubit extends Cubit<GetClassInfoState> {
  GetClassInfoUseCase getClassInfoUseCase;
  GetClassInfoCubit({required this.getClassInfoUseCase})
      : super(GetClassInfoInitial());

  Future<void> getClassInfo({required String classId}) async {
    emit(GetClassInfoLoading());

    try {
      final streamResponse = getClassInfoUseCase.call(classId);
      streamResponse.listen((classInfo) {       
        emit(GetClassInfoLoaded(classInfo: classInfo.first));
      });
    } on SocketException catch (_) {
      emit(GetClassInfoFailure());
    } catch (_) {
      emit(GetClassInfoFailure());
    }
  }
}
