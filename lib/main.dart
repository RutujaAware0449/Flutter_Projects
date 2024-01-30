
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_application/auth/auth_gate.dart';
import 'package:flutter_chat_application/firebase_options.dart';
import 'package:flutter_chat_application/pages/Registration_page.dart';
import 'package:flutter_chat_application/pages/login_page.dart';
import 'package:flutter_chat_application/themes/light_mode.dart';
import 'package:flutter_chat_application/themes/theme_provider.dart';
import 'package:provider/provider.dart';


import 'auth/Login_or_registration.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (context)=> ThemeProvider(),
    child: const MyApp(),),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
