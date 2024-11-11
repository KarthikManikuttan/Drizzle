// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/viewModels/services/chat_services.dart';
import 'package:drizzle/viewModels/services/user_state_service.dart';
import 'package:drizzle/views/screens/chat_page.dart';
import 'package:drizzle/views/screens/landing_page.dart';
import 'package:drizzle/views/theme/theme.dart';
import 'package:drizzle/views/utils/app_icons.dart';
import 'package:drizzle/views/utils/app_images.dart';
import 'package:drizzle/views/utils/utils.dart';
import 'package:drizzle/views/widgets/circle_img_container.dart';
import 'package:drizzle/views/widgets/build_user_tile_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  final ChatServices chatServices = ChatServices();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      UserStateService().updateUserState(status: "online");
    } else {
      UserStateService().updateUserState(status: timeago.format(DateTime.now()));
    }
    super.didChangeAppLifecycleState(state);
  }

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
                      onTap: () async {
                        dynamic result = await AuthServices().signOut();
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
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: CachedNetworkImageProvider(
                          AuthServices().getCurrentUser!.photoURL == null
                              ? AppImages.profileImage
                              : AuthServices().getCurrentUser!.photoURL!,
                        ),
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
                      child: StreamBuilder(
                        stream: chatServices.getUsersStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Error");
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              color: Theme.of(context).colorScheme.surface,
                              height: screenHeight(context),
                              width: screenWidth(context),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: primaryBlueColor,
                                ),
                              ),
                            );
                          }
                          return ListView(
                            children: snapshot.data!
                                .map<Widget>((userData) =>
                                    userData['email'] != AuthServices().getCurrentUser!.email
                                        ? UserTile(
                                            text: userData['userName'],
                                            receiverId: userData['uid'],
                                            profileImageUrl:
                                                userData['profileImage'] ?? AppImages.profileImage,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ChatPage(
                                                    imgPath: userData['image'],
                                                    userName: userData['userName'],
                                                    receiverId: userData['uid'],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : const SizedBox())
                                .toList(),
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
