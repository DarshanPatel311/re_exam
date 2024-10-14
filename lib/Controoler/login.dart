import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase/auth.dart';

class authController extends GetxController{
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtName = TextEditingController();

  var emailError = ''.obs;
  var passwordError = ''.obs;

  signUp(String email , String password){
    AuthService.authService.createAccount(email, password);
    if (validateForm()) {

      Get.snackbar('Login', 'Login Successfully');
    } else {

      Get.snackbar('Error', 'Please correct the errors');
    }
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    } else if (!email.contains('@gmail.com')) {
      emailError.value = 'Email must be a valid @gmail.com address';
      return false;
    } else {
      emailError.value = '';
      return true;
    }
  }
  bool validatePassword(String password) {
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      return false;
    } else if (password.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      return false;
    } else {
      passwordError.value = '';
      return true;
    }
  }
  bool validateForm() {
    final isEmailValid = validateEmail(txtEmail.text);
    final isPasswordValid = validatePassword(txtName.text);
    return isEmailValid && isPasswordValid;
  }




}