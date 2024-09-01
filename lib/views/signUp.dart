import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/utils/snack_bar.dart';
import 'package:chat_app/widgets/customtextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatelessWidget {
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
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is Registersuccess) {
                Navigator.of(context)
                    .pushReplacementNamed('SignInpage', arguments: email);
              } else if (state is RegisterFailed) {
                showSnackBar(context, state.errormessage);
              } else {
                isLoading = true;
              }
            },
            builder: (context, state) => Column(
              children: [
                const Spacer(
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
                const Row(
                  children: [
                    Text(
                      'SignUp',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomtextField(
                  onChange: (data) {
                    email = data;
                  },
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomtextField(
                  onChange: (data) {
                    password = data;
                  },
                  hint: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<RegisterCubit>(context)
                              .register(email: email!, password: password!);
                        },
                        child: const Text('SignUp'),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        ' SignIn',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<UserCredential> register() async {
  //   var auth = FirebaseAuth.instance;
  //   UserCredential credential = await auth.createUserWithEmailAndPassword(
  //     email: email!,
  //     password: password!,
  //   );
  //   return credential;
  // }
}
