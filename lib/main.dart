import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:list_nest2/SignUp.dart';
import 'package:list_nest2/Templets.dart';
import 'package:list_nest2/layout.dart';
import 'package:list_nest2/new_Form_provider.dart';
import 'package:list_nest2/show_form_provider.dart';
import 'package:provider/provider.dart';
import './my_providers.dart';

import 'package:get/get.dart';

import './Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lottie/lottie.dart';

import 'Filter_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => S_F_Provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => F_provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => new_form_provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => new_form_app_bar(),
        ),
        ChangeNotifierProvider(
          create: (context) => my_providers(),
        ),
      ],
      child: GetMaterialApp(
        builder: EasyLoading.init(),
        // theme: ThemeData.dark(useMaterial3: true),
        home: AnimatedSplashScreen(
          splash: Lottie.asset("lib/assets/images/Simple-Dot-[remix] (4).json",
              fit: BoxFit.cover, repeat: false),
          disableNavigation: false,
          duration: 1999,
          splashIconSize: double.infinity,
          backgroundColor: Color.fromARGB(255, 1, 11, 20),
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: user != null
              ? user!.emailVerified
                  ? Templets_page()
                  : Sign_Up_Page()
              : Login_Page(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
//  user != null ? Templets_page() : Login_Page(),





// GetMaterialApp(
//         // theme: ThemeData.dark(useMaterial3: true),
//         home: AnimatedSplashScreen(
//           splash: Lottie.asset("lib/assets/images/Simple-Dot-[remix] (4).json",
//               fit: BoxFit.cover, repeat: false),
//           disableNavigation: false,
//           duration: 1999,
//           splashIconSize: double.infinity,
//           backgroundColor: Color.fromARGB(255, 1, 11, 20),
//           splashTransition: SplashTransition.fadeTransition,
//           nextScreen: user != null ? Templets_page() : Login_Page(),
//         ),
//         debugShowCheckedModeBanner: false,
//       ),
//     );