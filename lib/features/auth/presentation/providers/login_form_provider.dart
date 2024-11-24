import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:teslo_shop/features/shared/shared.dart';

// PASSOS PER A IMPLEMENTAR PROVIDER
// 1-State del provider
class LoginFormState{
  final bool isLoading;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isFormPosted = false,
    this.isLoading = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure()});

  LoginFormState copyWith({
    bool? isLoading,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isLoading: isLoading ?? this.isLoading,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  String toString() {
    return '''
    LoginFormState:
      isFormPosted = $isFormPosted 
      isLoading = $isLoading 
      isValid = $isValid 
      email = $email 
      password = $password 
    ''';
  }
}
// 2-Com implementem un notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier(): super(LoginFormState());

  onEmailChange (String value){
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail,state.password])
    );
  }

  onPasswordChange (String value){
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword,state.password])
    );
  }

  onFormSubmit(){
    _touchEveryField();
    if(!state.isValid) return;
    print(state);

  }

  _touchEveryField(){
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email,password])
    );
  }
  
}
// 3-StateNotifierProvider - consum a fòra
// L'autoDispose el posem per a que un cop sortim de la pantalla
// si tornem a entrar no aparegui el que haguem posat
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier,LoginFormState>((Ref ref){
  return LoginFormNotifier();
});