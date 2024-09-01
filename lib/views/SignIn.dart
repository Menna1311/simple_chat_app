import 'package:chat_app/Login_cubit/login_cubit.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/utils/snack_bar.dart';
import 'package:chat_app/widgets/customtextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signin extends StatelessWidget {
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context)
              .pushReplacementNamed('ChatPage', arguments: email);
        } else if (state is LoginFailed) {
          showSnackBar(context, state.errormessage);
        } else {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: Column(
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
                        'SignIn',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomtextField(
                    obscureText: false,
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
                            BlocProvider.of<LoginCubit>(context)
                                .login(email: email!, password: password!);
                          },
                          child: const Text('SignIn'),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            'SignUpPage',
                          );
                        },
                        child: const Text(
                          ' Create one',
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
        );
      },
    );
  }
}
