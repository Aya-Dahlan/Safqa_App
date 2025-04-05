/// **🔹 حالات `Cubit`**
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> userData;
  AuthSuccess(this.userData);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

/// ✅ حالة جديدة عند إرسال OTP بنجاح
class OtpSentSuccess extends AuthState {}
