import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:kid_upp/features/welcome/domain/usecases/user/sign_in_user_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserCase signInUserCase;

  CredentialCubit({required this.signInUserCase}) : super(CredentialInitial());

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(CredentialLoading());
    try {
      await signInUserCase.call(UserEntity(email: email, passWord: password));
      emit(CredentialSuccess());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
