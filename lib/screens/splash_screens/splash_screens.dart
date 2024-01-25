import 'package:auto_route/annotations.dart';
import 'package:chat_demo/core/routes/app_router.dart';
import 'package:chat_demo/screens/auth/login/login_page.dart';
import 'package:chat_demo/screens/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
@RoutePage()
class SplashPage extends StatefulWidget {

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    _navigateTOHomeOrLogin();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: Text('Splash Page'),
      ),

    );
  }

  Future<void> _navigateTOHomeOrLogin()async{
    Future.delayed(const Duration(seconds: 1)).whenComplete(() {
      bool isLogin = true;
      /// check is login
      initializeFirebase(context: context);
      /* if(isLogin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),),);
      }else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
      }*/

    });
  }
   Future<void> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;
    debugPrint('Init User${user?.displayName} ');
    if(!mounted) return;
    if (user != null) {
      if(!mounted) return;
     /// home Route
    }else{

      //appRouter.push(const LoginRoute());
      appRouter.push(OtpRoute(verificationId: '', phoneNo: ''));

    }

   // return firebaseApp;
  }
}
