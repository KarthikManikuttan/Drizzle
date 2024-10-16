import 'package:device_preview/device_preview.dart';
import 'package:drizzle/viewModels/provider/login_provider.dart';
import 'package:drizzle/viewModels/provider/signup_provider.dart';
import 'package:drizzle/views/screens/homepage.dart';
import 'package:drizzle/views/screens/landing_page.dart';
import 'package:drizzle/views/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ],
      child: MaterialApp(
        title: 'Drizzle',
        theme: lightMode,
        darkTheme: darkMode,
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      ),
    );
  }
}
