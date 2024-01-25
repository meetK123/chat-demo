import 'package:auto_route/annotations.dart';
import 'package:chat_demo/screens/auth/auth.dart';
import 'package:chat_demo/screens/auth/controller/auth_controller.dart';
import 'package:chat_demo/screens/auth/signup/signup_page.dart';
import 'package:chat_demo/screens/home_page/home_page.dart';
import 'package:chat_demo/utils/utils.dart';
import 'package:chat_demo/values/extention.dart';
import 'package:chat_demo/widget/app_name_icon.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();

  late dynamic countryCode;

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  final ValueNotifier<bool> _obscure = ValueNotifier(false);

  late Auth auth;

  @override
  void initState() {
    // _emailFN.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _emailFN.dispose();
    _passwordFN.dispose();
    _obscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //auth = Provider.of<Auth>(context, listen: false);
    debugPrint('Focus${FocusScope.of(context).hasFocus}');
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: InkWell(
          onTap: FocusScope.of(context).hasFocus ? _unFocusOnTap : null,
          //splashColor: Colors.transparent,
          splashColor: Colors.white,
          focusColor: Colors.white,
          //autofocus: false,
          splashFactory: InkSparkle.splashFactory,
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.15),
                  const AppNameIcon(),
                  //_buildAppNameAndIcon(),
                  SizedBox(height: height * 0.20),

                  ///------------EMAIL---------------

                  _buildEmailField(context),
//                   SizedBox(height:height * 0.50),

                  ///------------PASSWORD---------------

                  // _buildPasswordField(),

                  const SizedBox(height: 50),

                  ///------------SIGN IN BUTTON---------------

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _sandPhoneNo,
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  ///------------OR DIVIDER---------------

                  /*Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(child: Divider(thickness: 1)),
                      Text('  or   ', style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                      const Expanded(child: Divider(thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 14),

                  ///------------SIGN IN WITH GOOGLE BUTTON---------------

                  _buildGoogleSignBtn(context),
                  const SizedBox(height: 14),

                  ///------------SIGN UP RECOMMENDATION---------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ? ',
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignupPage(),
                              ),
                            );
                          },
                          child: const Text('Sign up')),
                    ],
                  ),*/
                  //const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer), borderRadius: BorderRadius.circular(5)),
          child: CountryCodePicker(
            onInit: (CountryCode? value) {
              debugPrint('On Init $value');
              countryCode = value;
            },
            onChanged: (CountryCode value) {
              debugPrint('on Change $value');
              countryCode = value;
            },
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'IN',
            //favorite: const ['+39', 'FR'],
            // optional. Shows only country name and flag
            showCountryOnly: false,
            // optional. Shows only country name and flag when popup is closed.
            showOnlyCountryWhenClosed: false,
            // optional. aligns the flag and the Text left
            alignLeft: false,
            showFlagMain: false,
            padding: EdgeInsets.zero,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            // autofocus: true,
            controller: _phoneController,
            //  focusNode: _emailFN,
            validator: (String? value) => value != null
                ? value.isPhonValid()
                    ? null
                    : 'Please check Phone No.'
                : 'Please enter Phone No',
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
            //onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFN),
            decoration: _authTextFieldDecoration(labelText: 'Phone'),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return ValueListenableBuilder(
        valueListenable: _obscure,
        builder: (context, bool obscure, child) {
          return TextFormField(
            controller: _passwordController,
            validator: (String? value) => value != null
                ? value.isValidPassword()
                    ? null
                    : "Password should contain upper,lower,digit and Special character "
                : 'Please enter Password',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            // focusNode: _passwordFN,
            //  onEditingComplete: _submit,
            obscureText: _obscure.value,
            decoration: _authTextFieldDecoration(
              labelText: 'Password',
              suffix: SizedBox(
                height: 32,
                width: 28,
                child: IconButton(
                  onPressed: () => _obscure.value = !_obscure.value,
                  splashRadius: 18,
                  iconSize: 18,
                  icon: Icon(
                    !obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildGoogleSignBtn(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          User? user = await context.read<Auth>().signInWithGoogle();
          if (!mounted) return;
          if (user != null) {
            context.read<Auth>().saveUserInfoInDatabase();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupPage(),
              ),
            );
          }
          //  context.read<SignInBloc>().add(SignInWithGoogleEvent());
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.8),
            foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimaryContainer),
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_google.png', height: 16),
            10.horizontalSpace,
            const Text('Continue With Google'),
          ],
        ),
      ),
    );
  }

  InputDecoration _authTextFieldDecoration({required String labelText, Widget? suffix}) => InputDecoration(
        labelText: labelText,
        suffix: suffix,
        contentPadding: const EdgeInsets.all(12),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
      );

  void _unFocusOnTap() {
    FocusScope.of(context).unfocus();
  }

  Future<void> _sandPhoneNo() async {
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();

      String phoneNo = _phoneController.text.trim();

      // if (!mounted) return;
      if(countryCode != null && phoneNo.isNotEmpty){
        ref.read(authController).signInWithPhone(context, '+$countryCode$phoneNo');
      }else{
        showSnackBar(context: context, content: 'Fill out all the fields');
      }

    } else {
      showSnackBar(context: context, content: 'enter valid data');

    }
  }
}
