import 'package:chat_app/controllers/main_controller.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final MainController mainController = Get.put(MainController());
    final bool isDarkMode =
        mainController.brightness == Brightness.dark ? true : false;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatmate',
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
        scaffoldBackgroundColor: isDarkMode ? darkColor : Colors.white,
      ),
      home: user != null
          ? HomeScreen(
              user: user,
            )
          : const LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
