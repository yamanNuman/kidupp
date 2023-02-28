import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kid_upp/features/welcome/domain/entities/child/child_entity.dart';
import 'package:kid_upp/features/welcome/domain/usecases/child/get_child_info_usecase.dart';

part 'get_child_info_state.dart';

class GetChildInfoCubit extends Cubit<GetChildInfoState> {
  GetChildInfoUseCase getChildInfoUseCase;

  GetChildInfoCubit({required this.getChildInfoUseCase}) : super(GetChildInfoInitial());
  Future<void> getChildInfo({required String childId}) async {
    emit(GetChildInfoLoading());

    try {
      final streamResponse = getChildInfoUseCase.call(childId);
      streamResponse.listen((childInfo) {       
        emit(GetChildInfoLoaded(childInfo: childInfo.first));
      });
    } on SocketException catch (_) {
      emit(GetChildInfoFailure());
    } catch (_) {
      emit(GetChildInfoFailure());
    }
  }
}
