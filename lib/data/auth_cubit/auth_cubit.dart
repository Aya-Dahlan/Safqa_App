import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/data/auth_cubit/auth_state.dart';
import 'package:safqa_app/data/repos/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login(String phone, String password) async {
    emit(AuthLoading());
    final response = await _authRepository.login(phone, password);

    if (response['success']) {
      emit(AuthSuccess(response['data']));
    } else {
      if (response['message'].contains("Unauthorized")) {
        await _authRepository.logout();
        emit(AuthFailure("Session expired. Please log in again."));
      } else {
        emit(AuthFailure(response['message']));
      }
    }
  }

  Future<void> register(String name, String phone, String password,
      String confirmPassword) async {
    emit(AuthLoading());
    final response =
    await _authRepository.register(name, phone, password, confirmPassword);

    if (response['success']) {
      await sendOtp(phone);


      emit(AuthSuccess(response['data']));
    } else {
      emit(AuthFailure(response['message']));
    }
  }

  /// ✅ إرسال OTP
  Future<void> sendOtp(String phone) async {
    emit(AuthLoading());
    final response = await _authRepository.sendOtp(phone);

    if (response['success']) {

    await  verifyOtp(otp: response['data']['otp'], phoneNumber: phone);
      emit(OtpSentSuccess(
        OTPString: response['data']['otp']
      ));
    } else {
      emit(AuthFailure(response['message']));
    }
  }

  // ✅ التحقق من OTP
  Future<void> verifyOtp({
    required String otp,
    required String phoneNumber,
  }) async {
    emit(AuthLoading());
    final response = await _authRepository.verifyOtp(
      otp: otp,
      phoneNumber: phoneNumber,

    );

    if (response['success']) {
      emit(AuthSuccess(response['data']));
    } else {
      emit(AuthFailure(response['message']));
    }
  }


  /// ❌ تسجيل خروج المستخدم
  ///

  Future<void> logout(BuildContext context) async {

    await _authRepository.logout();

    GoRouter.of(context).go(AppRouter.kLoginScreen);
    emit(AuthLogoutSuccess());
  }
}
