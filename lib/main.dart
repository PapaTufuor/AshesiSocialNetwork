import 'package:finals1/Screens/CreatePostScreen.dart';
import 'package:finals1/Screens/FeedScreen.dart';
import 'package:finals1/Screens/HomeScreen.dart';
import 'package:finals1/Screens/ProfileScreen.dart';
import 'package:finals1/Screens/SignUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:finals1/Screens/EditProfileScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:finals1/Screens/Profile.dart';

import "package:finals1/Screens/WelcomeScreen.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // Widget getScreenId() {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return FeedScreen(currentUserId: snapshot.data?.uid ?? '');
  //         }
  //
  //         else {
  //           return WelcomeScreen();
  //         }
  //       }
  //   );
  // }


    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: WelcomeScreen(),
      );
    }}