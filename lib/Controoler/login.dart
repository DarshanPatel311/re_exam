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

  




}
