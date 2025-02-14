import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  ///SignUp
  Future<User?> signUpUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user!.sendEmailVerification();
    return userCredential.user;
  }

  ///Login
  Future<User?> loginUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  ///Forgot Password
  Future forgotPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
