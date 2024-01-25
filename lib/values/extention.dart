
import 'package:flutter/material.dart';

extension ExtentionWidget on Widget {

  addPadding(EdgeInsets edgeInsets){
    return Padding(padding: edgeInsets);
  }

}
extension Validator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
  bool isValidPassword(){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp =  RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool isPhonValid(){
    return RegExp('^[0-9]').hasMatch(this);
  }
}
