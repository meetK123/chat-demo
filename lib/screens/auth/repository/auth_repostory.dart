import 'package:chat_demo/core/routes/app_router.dart';
import 'package:chat_demo/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    fireStore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore fireStore;

  const AuthRepository({required this.firebaseAuth, required this.fireStore});

  void signInWithPhone(BuildContext context, String phoneNo) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          debugPrint('credential :- \n$credential');
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          appRouter.push(
            OtpRoute(
              verificationId: verificationId,
              phoneNo: phoneNo,
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showSnackBar(context: context, content: e.message ?? '');
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOTP);
      await firebaseAuth.signInWithCredential(phoneAuthCredential);

      //appRouter.replaceAll()

    } on FirebaseException catch (e, st) {
      debugPrint('on Verify Error $e');
      debugPrint('Stack Trace $st');
      if(!context.mounted)return;
      showSnackBar(context: context, content: e.message ??'');

    }
  }
}
