import 'package:chat_demo/screens/auth/repository/auth_repostory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authController = Provider((ref) {
  final authRepository = ref.watch(authRepoProvider);

  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void signInWithPhone(BuildContext context, String phoneNo) {
    authRepository.signInWithPhone(context, phoneNo);
  }

  void verifyOtp(BuildContext context, String verificationID, String userOtp) {
    authRepository.verifyOTP(
        context: context, verificationId: verificationID, userOTP: userOtp);
  }
}
