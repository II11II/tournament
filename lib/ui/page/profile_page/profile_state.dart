part of 'profile_cubit.dart';

class ProfileState {
  Player player;
  NetworkState state;
  String message;

  ProfileState({this.player, this.state=NetworkState.INITIAL, this.message});

  ProfileState copyWith(
      { Player player , String message, NetworkState state}) {
    return ProfileState(
        player: player ?? this.player,
        state: state ?? this.state,
        message: message ?? this.message);
  }
}
