import 'package:cached_network_image/cached_network_image.dart';
import 'package:drizzle/views/screens/chat_page.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String profileImageUrl;
  final String receiverId;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.text,
    this.onTap,
    required this.profileImageUrl, required this.receiverId,
  });

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              imgPath: profileImageUrl,
              userName: text,
              receiverId: receiverId,
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
              radius: 23,
              backgroundImage: CachedNetworkImageProvider(
                profileImageUrl,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: "Caros",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
