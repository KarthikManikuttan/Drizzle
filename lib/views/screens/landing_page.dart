import 'package:drizzle/views/screens/login_page.dart';
import 'package:drizzle/views/screens/signup_page.dart';
import 'package:drizzle/views/utils/app_icons.dart';
import 'package:drizzle/views/utils/app_images.dart';
import 'package:drizzle/views/utils/utils.dart';
import 'package:drizzle/views/widgets/circle_img_container.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.8,
            child: Image.asset(AppImages.landingBg),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: screenHeight(context),
            width: screenWidth(context),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Connect friends easily & quickly",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 43,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Outfit",
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      "Our chat app is the perfect way to stay connected with friends and family.",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleImgContainer(
                        img: AppIcons.fbIcon,
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      CircleImgContainer(
                        img: isDarkMode ? AppIcons.appleIcon : AppIcons.appleIconBk,
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      CircleImgContainer(
                        img: AppIcons.googleIcon,
                        onTap: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Theme.of(context).colorScheme.outline,
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
                            color: Theme.of(context).colorScheme.outline,
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          "SignUp with Email",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Outfit",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Existing account? ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 15),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}