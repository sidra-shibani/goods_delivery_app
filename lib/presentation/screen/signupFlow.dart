import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:goods_delivery_app/bussiness/Auth_cubit/signUp_cubit.dart';
import 'package:goods_delivery_app/datasource/repository/Auth_repo.dart';
import 'package:goods_delivery_app/presentation/screen/signup_screen.dart';

class SignupFlow extends StatelessWidget {
  const SignupFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(context.read<AuthRepository>()),

      child: const SignupScreen(),
    );
  }
}
