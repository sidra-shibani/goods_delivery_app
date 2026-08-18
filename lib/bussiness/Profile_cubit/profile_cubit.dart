import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Profile_cubit/profile_state.dart';

import 'package:goods_delivery_app/datasource/repository/Profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> fetchME() async {
    emit(ProfileLoading());

    final response = await repository.GetProfile();
    print(response);
    response.fold((error) {
      emit(ProfileError(error.message));
    }, (data) => emit(GetProfileLoaded(data)));
  }

  Future<void> updateProfilePicture(File image) async {
    emit(ProfileLoading());

    final result = await repository.updateProfilePicture(image);

    result.fold(
      (error) {
        emit(ProfileError(error.message));
      },
      (profile) {
        emit(GetProfileLoaded(profile));
      },
    );
  }
}
