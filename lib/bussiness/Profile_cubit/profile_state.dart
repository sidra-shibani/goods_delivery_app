import 'package:goods_delivery_app/datasource/model/profile_model.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class GetProfileLoaded extends ProfileState {
  final MeResponse me;

  GetProfileLoaded(this.me);
}
