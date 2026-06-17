import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:goods_delivery_app/bussiness/shipment_cubit/create_ship_cubit.dart';

import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';

import 'package:goods_delivery_app/presentation/widget/shipmentBottomSheet_widget.dart';

class ShipmentFlow extends StatelessWidget {
  const ShipmentFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateShipCubit(context.read<ShipmentRepo>()),

      child: const CreateShipmentBottomSheet(),
    );
  }
}
