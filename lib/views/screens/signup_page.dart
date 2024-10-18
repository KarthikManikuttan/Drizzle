// ignore_for_file: use_build_context_synchronously

import 'package:drizzle/models/signup_email_model.dart';
import 'package:drizzle/viewModels/provider/signup_provider.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/views/screens/homepage.dart';
import 'package:drizzle/views/utils/app_icons.dart';
import 'package:drizzle/views/utils/utils.dart';
import 'package:drizzle/views/widgets/auth_button_widget.dart';
import 'package:drizzle/views/widgets/build_textformfield_obscured_widget.dart';
import 'package:drizzle/views/widgets/build_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<SignUpProvider>(context, listen: false).textFieldValidation(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
      );
    });
    final signUpProvider = Provider.of<SignUpProvider>(context);
    final authServices = Provider.of<AuthServices>(context);

    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: screenHeight(context),
          width: screenWidth(context),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 50,
                      width: 25,
                      color: Colors.transparent,
                      child: SvgPicture.asset(isDarkMode ? AppIcons.backw : AppIcons.back)),
                ),
                const Spacer(),
                Text(
                  "Sign Up with Email",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Outfit",
                    height: 1.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 20, top: 10),
                  child: Text(
                    "Get chatting with friends and family today by signing up for our chat app!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Outfit",
                      height: 1.2,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "Your name",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Outfit",
                  ),
                ),
                BuildTextformfieldWidget(
                  textController: nameController,
                ),
                const SizedBox(height: 30),
                Text(
                  "Your email",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Outfit",
                  ),
                ),
                BuildTextformfieldWidget(
                  textController: emailController,
                ),
                const SizedBox(height: 30),
                Text(
                  "Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Outfit",
                  ),
                ),
                BuildTextformfieldObscuredWidget(
                  textController: passwordController,
                ),
                const SizedBox(height: 30),
                Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Outfit",
                  ),
                ),
                BuildTextformfieldObscuredWidget(
                  textController: confirmPasswordController,
                ),
                const Spacer(flex: 2),
                AuthButtonWidget(
                  onTap: signUpProvider.hasText && signUpProvider.isPasswordValidated
                      ? () {
                          authServices
                              .signUpWithEmail(
                            signUpEmailModel: SignupEmailModel(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          )
                              .then((result) {
                            if (result == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Homepage(),
                                ),
                              );
                            } else {
                              final snackBar = SnackBar(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  result,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          });
                        }
                      : null,
                  buttonColor: signUpProvider.toggleContainerColor(),
                  textColor: signUpProvider.toggleContainerTextColor(),
                  isLoading: authServices.isLoading,
                  text: "Create an account",
                ),
                SizedBox(height: screenHeight(context, dividedBy: 23))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
