part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class AddProfileEvent extends ProfileEvent {
  final Profile? profile;

  AddProfileEvent(this.profile);
}

class DeleteProfileEvant extends ProfileEvent {
  final int id;

  DeleteProfileEvant(this.id);
}

class UpdateProfileEvant extends ProfileEvent {
  final int id;
  final Profile profile;

  UpdateProfileEvant(this.id, this.profile);
}
