// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_manage/models/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    List<Profile> _profile = [];

    ///
    on<AddProfileEvent>((event, emit) {
      emit(ProfileLoading());
      if (event.profile == null) {
        emit(ProfileFinish(profiles: _profile));
        return;
      } else {
        _profile.add(event.profile!);
        // print(_profile);
        emit(ProfileFinish(profiles: _profile));
      }
    });

    on<DeleteProfileEvant>((event, emit) {
      emit(ProfileLoading());

      // print('id===>${event.id}');
      _profile.removeAt(event.id);
      emit(ProfileFinish(profiles: _profile));
    });

    on<UpdateProfileEvant>((event, emit) {
      emit(ProfileLoading());

      // print('id===>${event.id}');
      _profile[event.id] = event.profile;
      emit(ProfileFinish(profiles: _profile));
    });
  }
}
