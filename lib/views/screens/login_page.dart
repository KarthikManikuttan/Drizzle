// ignore_for_file: use_build_context_synchronously
import 'package:drizzle/models/signin_email_model.dart';
import 'package:drizzle/viewModels/provider/login_provider.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/views/screens/homepage.dart';
import 'package:drizzle/views/theme/theme.dart';
import 'package:drizzle/views/utils/app_icons.dart';
import 'package:drizzle/views/utils/utils.dart';
import 'package:drizzle/views/widgets/auth_button_widget.dart';
import 'package:drizzle/views/widgets/build_textformfield_obscured_widget.dart';
import 'package:drizzle/views/widgets/build_textformfield_widget.dart';
import 'package:drizzle/views/widgets/circle_img_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginProvider>(context, listen: false).textFieldValidation(
        emailController: emailController,
        passwordController: passwordController,
      );
    });

    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final loginProvider = Provider.of<LoginProvider>(context);
    final authServices = Provider.of<AuthServices>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    const SizedBox(height: 30),
                    Text(
                      "Log in to Drizzle",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Outfit",
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        "Welcome back! Sign in using your social account or email to continue us",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Outfit",
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleImgContainer(
                          img: AppIcons.fbIcon,
                          onTap: () async {
                            dynamic result = await authServices.signInWithFacebook();
                            if (result == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Homepage(),
                                ),
                              );
                            } else {
                              final snackBar = SnackBar(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                duration: const Duration(seconds: 1),
                                content: const Text(
                                  "Unexpected  error occured !",
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                        ),
                        const SizedBox(width: 10),
                        CircleImgContainer(
                          img: AppIcons.googleIcon,
                          onTap: () async {
                            dynamic result = await AuthServices().signInWithGoogle();
                            if (result == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Homepage(),
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
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.7),
                              thickness: 0.5,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'OR',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Outfit",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.7),
                              thickness: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    const Spacer(),
                    AuthButtonWidget(
                      onTap: loginProvider.hasText
                          ? () async {
                              dynamic result = await authServices.loginWithEmail(
                                signInEmailModel: SigninEmailModel(
                                    email: emailController.text, password: passwordController.text),
                              );
                              if (result == null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homepage(),
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
                            }
                          : null,
                      textColor: loginProvider.toggleContainerTextColor(),
                      buttonColor: loginProvider.toggleContainerColor(),
                      text: "Log in",
                      isLoading: false,
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Outfit",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight(context, dividedBy: 15))
                  ],
                ),
              ),
            ),
          ),
          authServices.isLoading
              ? Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  color: Colors.black.withOpacity(0.8),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: primaryBlueColor,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
