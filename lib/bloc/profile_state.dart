part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  @override
  String toString() => 'loading...';
}

class ProfileError extends ProfileState {
  final String? mssage;

  ProfileError({this.mssage});

  @override
  String toString() => mssage ?? "null";
}

class ProfileFinish extends ProfileState {
  final List<Profile>? profiles;

  ProfileFinish({this.profiles});
}
