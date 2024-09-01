part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class Registersuccess extends RegisterState {}

final class RegisterFailed extends RegisterState {
  final String errormessage;

  RegisterFailed({required this.errormessage});
}
