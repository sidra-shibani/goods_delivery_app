import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:goods_delivery_app/bussiness/Auth_cubit/login_cubit.dart';
import 'package:goods_delivery_app/datasource/model/otp_model.dart';
import 'package:goods_delivery_app/datasource/model/register_model.dart';
import 'package:goods_delivery_app/datasource/repository/Auth_repo.dart';

class SignUpCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController commercialController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey3 = GlobalKey<FormState>();

  final otpController = TextEditingController();
  SignUpCubit(this.repository) : super(AuthInitial());

  Future<void> signUp(RegisterRequest registerData) async {
    emit(AuthLoading());

    try {
      final result = await repository.signUp(registerData);

      result.fold(
        (error) {
          emit(AuthError(error.message));
        },
        (response) async {
          emit(AuthLoadedRegister(response));
        },
      );
    } catch (e) {
      emit(AuthError('An unexpected error occurred.'));
    }
  }

  Future<void> otpSend(SendOtpRequest request) async {
    emit(AuthLoading());

    final result = await repository.otpSend(request);

    result.fold(
      (error) => emit(AuthError(error.message)),
      (response) => emit(AuthLoadedSendOtp(response)),
    );
  }

  Future<void> otpVer(VerifyOtpRequest request) async {
    emit(AuthLoading());

    final result = await repository.otpVer(request);

    result.fold(
      (error) => emit(AuthError(error.message)),
      (response) => emit(AuthLoadedVerOtp(response)),
    );
  }
}
