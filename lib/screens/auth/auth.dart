
import 'package:chat_demo/core/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  bool _isLogin = false;

  bool get isLogin => _isLogin;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void checkIs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isLogin = sharedPreferences.getBool('isLogin') ?? false;
  }

  Future<User?> signInWithGoogle() async {
    String? name;
    String? email;


  //  final FirebaseAuth _auth = FirebaseAuth.instance;
    // Trigger the authentication flow
    try {
      /*final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);*/

      /// !--- @ 2 SECOND METHOD ---->
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      assert(user?.email != null);
      assert(user?.displayName != null);
      assert(user?.photoURL != null);
      name = user?.displayName;
      email = user?.email;

      if (name!.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }
      assert(!user!.isAnonymous);
      assert(await user?.getIdToken() != null);
      final User currentUser = _auth.currentUser!;
      assert(
        user?.uid == currentUser.uid,
      );

      debugPrint('NAME $name');
      debugPrint('Email $email');

      return user;
    } on FirebaseException catch (e) {
      debugPrint('\n----- Error -----\n');
      debugPrint('Error$e');
    }
    return null;
  }

  Future saveUserInfoInDatabase() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      debugPrint("Name is ${user.displayName}");
      debugPrint("Email is ${user.displayName}");
      debugPrint("PhotoUrl is ${user.photoURL}");
      debugPrint("PhoneNumber is ${user.phoneNumber}");
      Map<String, dynamic> userInfoMap = {
        "userId": user.email,
        "userEmail": user.email,
        "userName": user.displayName,
        "userImageUrl": user.photoURL,
        "addedPhoneNumber": user.phoneNumber,
      };
      await DatabaseServices().addUserInfo(user.email!, userInfoMap).whenComplete(() => print("UserInfo added Complete! 😏😏😏😏😏😏"));
    } on FirebaseException catch (e) {
      debugPrint('Firebase error $e');
    } on Exception catch (e, st) {
      debugPrint('\nError : $e');
      debugPrint('\nStack Trace : $st');
    }
  }

  ///user login
  void login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {

      /* if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }*/


    }

    /// signup
    void createUser(String email, String password) async {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        debugPrint('');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    /// update user
    void updateUser() {}

    /// delete user
    void deleteUser() {}

    /// sing out
    void signOut() async {
      try {
        /*final GoogleSignInAccount? _googleSignin =  await GoogleSignIn.signIn();
      if (await GoogleSignIn.isSignedIn()) {
        await GoogleSignIn.disconnect();
      }
*/

        await FirebaseAuth.instance.signOut();
      } on Exception catch (e) {
        debugPrint('Error $e');
      }
    }
  }


  Future<void> _singingInWithPhone(String phoneNo) async {

    final result = await  _auth.signInWithPhoneNumber(phoneNo,);


  }


}
