import 'package:drizzle/viewModels/services/notification_services.dart';
import 'package:drizzle/views/theme/theme.dart';
import 'package:drizzle/views/utils/utils.dart';
import 'package:drizzle/views/widgets/build_message_container.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drizzle/viewModels/services/chat_services.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/views/utils/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/chat_textformfield_widget.dart';

class ChatPage extends StatefulWidget {
  final String imgPath;
  final String userName;
  final String receiverId;

  const ChatPage({
    super.key,
    required this.imgPath,
    required this.userName,
    required this.receiverId,
  });

  static String? activeChatId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatServices _chatService = ChatServices();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final String senderId = AuthServices().getCurrentUser!.uid;

  @override
  void initState() {
    super.initState();
    ChatPage.activeChatId = ChatServices().getChatId(senderId, widget.receiverId);

    NotificationServices().listenForNewMessages(senderId, widget.receiverId);
  }

  @override
  void dispose() {
    ChatPage.activeChatId = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    FocusNode myFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
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
                backgroundImage: CachedNetworkImageProvider(widget.imgPath),
                radius: 23,
              ),
              const SizedBox(width: 20),
              Text(
                widget.userName,
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatService.getMessages(senderId, widget.receiverId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryBlueColor,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryBlueColor,
                    ),
                  );
                }
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    }
                  });
                }
                return ListView(
                  controller: scrollController,
                  children: snapshot.data!.docs
                      .map((documentSnapshot) => BuildMessageContainer(
                            documentSnapshot: documentSnapshot,
                          ))
                      .toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ChatTextformfieldWidget(
                    textController: textController,
                    myFocusNode: myFocusNode,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (textController.text.trim().isNotEmpty) {
                      await _chatService.sendMessage(widget.receiverId, textController.text.trim());
                      textController.clear();

                      if (scrollController.hasClients) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
