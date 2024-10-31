import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:drizzle/firebase_options.dart';
import 'package:drizzle/viewModels/provider/login_provider.dart';
import 'package:drizzle/viewModels/provider/signup_provider.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/views/screens/homepage.dart';
import 'package:drizzle/views/screens/landing_page.dart';
import 'package:drizzle/views/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'high_importance_channel',
        channelKey: 'basic_channel',
        channelName: 'Basic notification',
        channelDescription: 'Notification Channel for basic tests',
        defaultColor: const Color(0xff9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        onlyAlertOnce: true,
        playSound: true,
        criticalAlerts: true,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'high_importance_group_channel',
        channelGroupName: "group1",
      ),
    ],
    debug: true,
  );

  // runApp(
  //   DevicePreview(
  //     builder: (context) => const MyApp(),
  //   ),
  // );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => AuthServices()),
      ],
      child: MaterialApp(
        title: 'Drizzle',
        theme: lightMode,
        darkTheme: darkMode,
        debugShowCheckedModeBanner: false,
        home: auth.currentUser != null ? Homepage() : const LandingPage(),
      ),
    );
  }
}
