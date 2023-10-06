import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/data/base_error.dart';
import 'package:intern/data/model/auth/auth_model.dart';

import '../../../../data/repo/auth_repo/auth_repo_impl.dart';
import '../../../../domain/repo/auth_repo/auth_repo.dart';
import 'auth_states.dart';

class LoginViewModel extends Cubit<AuthState>{
  LoginViewModel() :super(AuthInitialState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  AuthRepo repo = AuthRepoImpl();

  bool isVisible = false;
  void visibility() {
    isVisible = !isVisible;
    emit(LoginToggleState(isVisibale: isVisible));
  }
  login()async{
    if(!formKey.currentState!.validate()) return;
    emit(AuthLoadingState());
    Either<BaseError,AuthResponse> either = await repo.login(username: emailController.text, password: passwordController.text);

    either.fold((error) {
      emit(AuthErrorState(message: error.message));
    }, (response) {
      emit(AuthSuccessState());
    });
  }

}
