import 'package:chat_app/Login_cubit/login_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/SignIn.dart';
import 'package:chat_app/views/chatScreen.dart';
import 'package:chat_app/views/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        routes: {
          'SignInpage': (context) => Signin(),
          'SignUpPage': (context) => Signup(),
          'ChatPage': (context) => ChatScreen(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: 'SignInpage',
      ),
    );
  }
}
