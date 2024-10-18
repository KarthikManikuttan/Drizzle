// ignore_for_file: use_build_context_synchronously

import 'package:drizzle/viewModels/profiles_view_models.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/views/screens/chat_page.dart';
import 'package:drizzle/views/screens/landing_page.dart';
import 'package:drizzle/views/utils/app_icons.dart';
import 'package:drizzle/views/utils/app_images.dart';
import 'package:drizzle/views/utils/utils.dart';
import 'package:drizzle/views/widgets/circle_img_container.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleImgContainer(
                      img: isDarkMode ? AppIcons.searchBk : AppIcons.search,
                      onTap: () {},
                      color: const Color(0xff363F3B),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Outfit",
                        height: 1.2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AuthServices().signOut().then(
                          (result) {
                            if (result == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LandingPage(),
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
                        );
                      },
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage(AppImages.testAvatar),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return false;
                      },
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Theme.of(context).colorScheme.outline,
                          thickness: 0.15,
                        ),
                        itemCount: ProfilesViewModels().profiles.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    imgPath: ProfilesViewModels().profiles[index].imgPath,
                                    userName: ProfilesViewModels().profiles[index].userName,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              height: 60,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(ProfilesViewModels().profiles[index].imgPath),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    ProfilesViewModels().profiles[index].userName,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Caros",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
