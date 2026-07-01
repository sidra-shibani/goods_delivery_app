import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:goods_delivery_app/bussiness/Auth_cubit/login_cubit.dart';
import 'package:goods_delivery_app/bussiness/Rating_cubit/giveRating_cubit.dart';

import 'package:goods_delivery_app/bussiness/shipment_cubit/create_ship_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/getShip_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/price_cubit.dart';
import 'package:goods_delivery_app/datasource/repository/Auth_repo.dart';
import 'package:goods_delivery_app/datasource/repository/Rating_repo.dart';
import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';

import 'package:goods_delivery_app/datasource/webserver/Auth_server.dart';
import 'package:goods_delivery_app/datasource/webserver/rating_server.dart';
import 'package:goods_delivery_app/datasource/webserver/shipment_server.dart';

import 'package:goods_delivery_app/presentation/screen/welcomepage_screen.dart';
import 'package:provider/provider.dart';

void main() async {
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
        //Rating
        Provider<RatingServer>(create: (_) => RatingServer()),
        Provider<RatingRepo>(
          create: (context) => RatingRepo(context.read<RatingServer>()),
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
          BlocProvider<GetShipCubit>(
            create: (context) =>
                GetShipCubit(context.read<ShipmentRepo>())..fetchShip(),
          ),
          BlocProvider<PriceCubit>(
            create: (context) => PriceCubit(context.read<ShipmentRepo>()),
          ),
          BlocProvider<GiveratingCubit>(
            create: (context) => GiveratingCubit(context.read<RatingRepo>()),
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
