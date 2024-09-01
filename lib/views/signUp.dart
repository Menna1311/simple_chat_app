import 'package:chat_app/constant.dart';
import 'package:chat_app/utils/snack_bar.dart';
import 'package:chat_app/widgets/customtextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

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
                    'SignUp',
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
                            UserCredential credential = await register();
                            showSnackBar(context, 'sucess');
                            print(credential.user!.email);
                            // Navigator.pop(context);
                            await credential.user?.sendEmailVerification();
                            showSnackBar(context, 'Check your email');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context, 'weak-password');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(context, 'this email already exist');
                            } else {
                              showSnackBar(context, 'Registration failed');
                            }
                          } finally {
                            isLoading = false;
                            setState(() {});
                          }
                        }
                      },
                      child: Text('SignUp'),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      ' SignIn',
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

  Future<UserCredential> register() async {
    var auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return credential;
  }
}
