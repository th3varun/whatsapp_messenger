import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';

final authRepositoryProvider = Provider(
  (ref) {
    return AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    );
  },
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: smsCode,
      );
      await auth.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.userInfo,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showAlertDialog(context: context, message: e.toString());
        },
        codeSent: (smsCodeId, resendSmsCodeId) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.verification,
            (route) => false,
            arguments: {
              'phoneNumber': phoneNumber,
              'smsCodeId': smsCodeId,
            },
          );
        },
        codeAutoRetrievalTimeout: (String smsCodeId) {},
      );
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
