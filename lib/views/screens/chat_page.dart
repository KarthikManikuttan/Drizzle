import 'package:drizzle/views/utils/app_icons.dart';
import 'package:drizzle/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatelessWidget {
  final String imgPath;
  final String userName;
  const ChatPage({
    super.key,
    required this.imgPath,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: screenWidth(context),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 30,
                    width: 20,
                    color: Colors.transparent,
                    child: SvgPicture.asset(isDarkMode ? AppIcons.backw : AppIcons.back)),
              ),
              const SizedBox(width: 20),
              CircleAvatar(
                backgroundImage: AssetImage(imgPath),
                radius: 23,
              ),
              const SizedBox(width: 20),
              Text(
                userName,
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
        automaticallyImplyLeading: false,
      ),
      body: Container(),
    );
  }
}
