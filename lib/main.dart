import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tuni_web/firebase_options.dart';
import 'package:tuni_web/provider/drop_down_provider.dart';
import 'package:tuni_web/provider/navigation_provider.dart';
import 'package:tuni_web/provider/product_provider.dart';
import 'package:tuni_web/screens/Login/login_screen.dart';
import 'package:tuni_web/screens/SplashScreen/splashScreen.dart';
import 'package:tuni_web/screens/side_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DropdownProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ProductImageProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => ImageDetailPageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shak Admin',
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.grey.shade500)),
        // Use SplashPage as the initial route
        initialRoute: '/',
        routes: {
          // Define route for SplashPage
          '/': (context) => SplashPage(),
          // Define route for SideNavPage
          '/home': (context) => const SideNavPage(),
          // Define route for LoginPage
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
