import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Auth_cubit.dart/login_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/create_ship_cubit.dart';
import 'package:goods_delivery_app/datasource/repository/Auth_repo.dart';
import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';
import 'package:goods_delivery_app/datasource/webserver/Auth_server.dart';
import 'package:goods_delivery_app/datasource/webserver/shipment_server.dart';
import 'package:goods_delivery_app/presentation/screen/logIn_screen.dart';

import 'package:goods_delivery_app/presentation/screen/welcomepage_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Auth
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<AuthRepository>(
          create: (context) => AuthRepository(context.read<AuthService>()),
        ),
        //shipment
        Provider<ShipmentServer>(create: (_) => ShipmentServer()),
        Provider<ShipmentRepo>(
          create: (context) => ShipmentRepo(context.read<ShipmentServer>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(context.read<AuthRepository>()),
          ),
          BlocProvider<CreateShipCubit>(
            create: (context) => CreateShipCubit(context.read<ShipmentRepo>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        ),
      ),
    );
  }
}
