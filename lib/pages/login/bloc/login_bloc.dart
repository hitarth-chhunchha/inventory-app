import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/global.dart';
import '../../../constants/storage_keys.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(hidePassword: !state.hidePassword, errorMessage: null));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    if (event.mobile == Global.validMobileNumber &&
        event.password == Global.validPassword) {
      final box = await Hive.openBox(StorageKeys.loginBoxName);
      await box.put(StorageKeys.isLoggedInKey, true);

      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: AppStrings.invalidMobileOrPassword,
        ),
      );
    }
  }
}
