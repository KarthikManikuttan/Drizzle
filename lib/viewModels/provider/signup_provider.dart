import 'package:drizzle/views/theme/theme.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  bool hasName = false;
  bool hasEmail = false;
  bool hasPassword = false;
  bool hasConfirmPassword = false;
  bool hasText = false;
  bool isPasswordValidated = false;

  void textFieldValidation({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
    required TextEditingController confirmPasswordController,
  }) {
    emailController.addListener(() {
      emailController.text.trim().isNotEmpty
          ? hasEmail = true
          : hasEmail = false;
      hasEmail && hasPassword && hasName && hasConfirmPassword == true
          ? hasText = true
          : hasText = false;
      notifyListeners();
    });
    passwordController.addListener(() {
      passwordController.text.trim().isNotEmpty
          ? hasPassword = true
          : hasPassword = false;
      hasEmail && hasPassword && hasName && hasConfirmPassword == true
          ? hasText = true
          : hasText = false;
      confirmPasswordController.text.trim() == passwordController.text.trim()
          ? isPasswordValidated = true
          : isPasswordValidated = false;
      notifyListeners();
    });
    nameController.addListener(() {
      nameController.text.trim().isNotEmpty ? hasName = true : hasName = false;
      hasEmail && hasPassword && hasName && hasConfirmPassword == true
          ? hasText = true
          : hasText = false;
      notifyListeners();
    });
    confirmPasswordController.addListener(() {
      confirmPasswordController.text.trim().isNotEmpty
          ? hasConfirmPassword = true
          : hasConfirmPassword = false;
      hasEmail && hasPassword && hasName && hasConfirmPassword == true
          ? hasText = true
          : hasText = false;
      confirmPasswordController.text.trim() == passwordController.text.trim()
          ? isPasswordValidated = true
          : isPasswordValidated = false;
      notifyListeners();
    });
  }

  Color toggleContainerColor() {
    return hasText && isPasswordValidated
        ? primaryBlueColor
        : const Color(0xffF3F6F6);
  }

  Color toggleContainerTextColor() {
    Color color =
        hasText && isPasswordValidated ? Colors.white : const Color(0xff797C7B);
    return color;
  }
}
