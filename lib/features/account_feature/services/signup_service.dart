import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignInService {
  Future<UserCredential> signIn();
  Future<void> logOut();
}

class SignInServiceImpl implements SignInService {
  final FirebaseAuth _firebaseAuth;

  SignInServiceImpl(this._firebaseAuth);

  @override
  Future<UserCredential> signIn() async {

    if(kIsWeb) {
      final googleProvider = GoogleAuthProvider();

      googleProvider.setCustomParameters({
        'login_hint': 'user@example.com'
      });

      return await _firebaseAuth.signInWithPopup(googleProvider);
    }
    else {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}