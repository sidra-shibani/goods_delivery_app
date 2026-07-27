import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:goods_delivery_app/datasource/model/login_model.dart';
import 'package:goods_delivery_app/datasource/model/otp_model.dart';
import 'package:goods_delivery_app/datasource/model/register_model.dart';
import 'package:goods_delivery_app/datasource/repository/Auth_repo.dart';

part 'Auth_state.dart';

class LoginCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  LoginCubit(this.repository) : super(AuthInitial());

  Future<void> login(String phone, String password) async {
    emit(AuthLoading());

    try {
      final result = await repository.login(phone, password);

      result.fold(
        (error) {
          emit(AuthError(error.message));
        },
        (response) async {
          emit(AuthLoadedLogin(response));
        },
      );
    } catch (e) {
      emit(AuthError('An unexpected error occurred.'));
    }
  }
}
