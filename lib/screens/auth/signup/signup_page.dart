import 'package:auto_route/annotations.dart';
import 'package:chat_demo/screens/home_page/home_page.dart';
import 'package:chat_demo/widget/app_name_icon.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FocusNode _usernameFNode = FocusNode();
  final FocusNode _displayNameFNode = FocusNode();
  final FocusNode _emailFNode = FocusNode();
  final FocusNode _passwordFNode = FocusNode();

  late final TextEditingController _usernameController = TextEditingController();
  late final TextEditingController _displayNameController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obscure = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {


    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: InkWell(
            onTap: FocusScope.of(context).hasFocus ? _unFocusOnTap : null,
            focusColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.05),

                    //------------APP LOGO AND NAME ---------------
                    const AppNameIcon(),
                    SizedBox(height: height * 0.1),

                    //------------USERNAME---------------

                    TextFormField(
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value == null) return null;
                        if (value.isEmpty) {
                          return 'Please enter user name';
                        }
                        return null;
                      },
                      focusNode: _usernameFNode,
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_displayNameFNode),
                      decoration: _textFieldDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 14),

                    //------------DISPLAY NAME---------------0

                    TextFormField(
                      controller: _displayNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                       validator: (String? value) {
                        if(value == null)return null;
                         if(value.isEmpty){
                           return 'Please enter display name';
                         }
                       },
                      focusNode: _displayNameFNode,
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_emailFNode),
                      decoration: _textFieldDecoration(
                        labelText: 'Display name',
                      ),
                    ),
                    const SizedBox(height: 14),

                    //------------EMAIL---------------

                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if(value == null )return null;
                        if(value.isEmpty)return 'Please enter email';
                      },
                      focusNode: _emailFNode,
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFNode),
                      decoration: _textFieldDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 14),

                    //------------PASSWORD---------------

                    ValueListenableBuilder(
                      valueListenable: _obscure,
                      builder: (context, bool obscure, child) => TextFormField(
                        obscureText: obscure,
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if(value == null )return null;
                         if(value.isEmpty) return 'Please enter password';

                        },
                        keyboardType: TextInputType.visiblePassword,
                        focusNode: _passwordFNode,
                        //  onEditingComplete: () => _submit(),
                        decoration: _textFieldDecoration(
                          labelText: 'Password',
                          //   errorText:,
                          suffix: SizedBox(
                            height: 32,
                            width: 28,
                            child: IconButton(
                              onPressed: () => _obscure.value = !_obscure.value,
                              splashRadius: 18,
                              iconSize: 18,
                              icon: Icon(
                                obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.05),

                    //------------SIGN UP BUTTON---------------

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Sign Up'),
                      ),
                    ),
                    const SizedBox(height: 14),

                    //------------OR DIVIDER---------------

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        Text('  or   ', style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),

                    //------------SIGN UP WITH GOOGLE BUTTON---------------

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0.8),
                            foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimaryContainer),
                            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/ic_google.png', height: 16),
                            const Text('  Continue With Google'),
                          ],
                        ),
                      ),
                    ),

                    //------------SIGN IN RECOMMENDATION---------------

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ? ',
                          style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimaryContainer),
                        ),
                        Hero(
                          tag: 'index',
                          child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Sign in')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    /// check state validation
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {


    }
  }

  void _unFocusOnTap() {
    FocusScope.of(context).unfocus();
  }

  InputDecoration _textFieldDecoration({required String labelText, String? errorText, Widget? suffix}) => InputDecoration(
        labelText: labelText,
        errorText: errorText,
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.all(12),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        suffix: suffix,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      );
}
