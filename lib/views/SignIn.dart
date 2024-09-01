import 'package:chat_app/constant.dart';
import 'package:chat_app/utils/snack_bar.dart';
import 'package:chat_app/widgets/customtextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Signin extends StatefulWidget {
  Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String? email;

  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Spacer(
                flex: 1,
              ),
              Image.asset('assets/images/icons8-chat-100.png'),
              const Text(
                'Chat App',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text(
                    'SignIn',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomtextField(
                onChange: (data) {
                  email = data;
                },
                hint: 'Email',
              ),
              SizedBox(
                height: 20,
              ),
              CustomtextField(
                onChange: (data) {
                  password = data;
                },
                hint: 'Password',
              ),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            UserCredential credential = await login();
                            Navigator.pushNamed(context, 'ChatPage',
                                arguments: email);
                            print(credential.user!.email);
                            // if (credential.user!.emailVerified) {
                            //   Navigator.pushNamed(context, 'ChatPage');
                            // } else {
                            //   showSnackBar(context, 'Please check your email');
                            // }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(
                                  context, 'No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context,
                                  'Wrong password provided for that user.');
                            } else {
                              showSnackBar(
                                  context, 'Login failed, please try again');
                            }
                          } finally {
                            isLoading = false;
                            setState(() {});
                          }
                        }
                      },
                      child: Text('SignIn'),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        'SignUpPage',
                      );
                    },
                    child: Text(
                      ' Create one',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> login() async {
    var auth = FirebaseAuth.instance;
    UserCredential credential = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return credential;
  }
}
