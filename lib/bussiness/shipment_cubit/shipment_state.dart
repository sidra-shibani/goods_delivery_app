import 'dart:io';

import 'package:goods_delivery_app/datasource/model/shipment_model.dart';

abstract class ShipmentState {}

class ShipInitial extends ShipmentState {}

class ShipLoading extends ShipmentState {}

class ShipError extends ShipmentState {
  final String message;
  ShipError(this.message);
}

class createShipLoaded extends ShipmentState {
  final ShipmentResponse response;

  createShipLoaded(this.response);
}

class GetShipLoaded extends ShipmentState {
  final ShipmentResponse shipment;

  GetShipLoaded(this.shipment);
}

class GetPriceLoaded extends ShipmentState {
  final ShipmentPriceResponse price;

  GetPriceLoaded(this.price);
}

class RouteCalculatedState extends ShipmentState {}

class MediaUpdated extends ShipmentState {
  final List<File> images;
  MediaUpdated(this.images);
}
