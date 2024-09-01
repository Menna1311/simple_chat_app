import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    var auth = FirebaseAuth.instance;
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailed(errormessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailed(errormessage: 'wrong password'));
      } else {
        emit(LoginFailed(errormessage: 'Login failed, please try again'));
      }
    }
  }
}
