import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> register(
      {required String email, required String password}) async {
    var auth = FirebaseAuth.instance;
    emit(RegisterLoading());
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(Registersuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailed(errormessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailed(errormessage: 'email is already exist'));
      } else {
        emit(RegisterFailed(errormessage: 'something went wrong'));
      }
    }
  }
}
