import 'package:drizzle/views/theme/theme.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool hasEmail = false;
  bool hasPassword = false;
  bool hasName = false;
  bool hasConfirmPassword = false;
  bool hasText = false;

  void textFieldValidation({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    emailController.addListener(() {
      emailController.text.trim().isNotEmpty ? hasEmail = true : hasEmail = false;
      hasEmail && hasPassword == true ? hasText = true : hasText = false;
      notifyListeners();
    });
    passwordController.addListener(() {
      passwordController.text.trim().isNotEmpty ? hasPassword = true : hasPassword = false;
      hasEmail && hasPassword == true ? hasText = true : hasText = false;
      notifyListeners();
    });
  }

  Color toggleContainerColor() {
    return hasText ? primaryBlueColor : const Color(0xffF3F6F6);
  }

  Color toggleContainerTextColor() {
    Color color = hasText ? Colors.white : const Color(0xff797C7B);
    return color;
  }
}
