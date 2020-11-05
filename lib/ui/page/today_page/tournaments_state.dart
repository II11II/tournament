part of 'tournaments_cubit.dart';

class TournamentsState {
  List<Tournament> tournaments;
  Function getTournaments;
  NetworkState networkState;
  String message;

  TournamentsState(this.getTournaments,
      {this.networkState = NetworkState.INITIAL,
      this.message,
      this.tournaments});

  TournamentsState copyWith(
      {NetworkState networkState,
      List<Tournament> tournaments,
      Function getTournaments,
      String message}) {
    return TournamentsState(
      getTournaments ?? this.getTournaments,
      tournaments: tournaments ?? this.tournaments,
      networkState: networkState ?? this.networkState,
      message: message ?? this.message,
    );
  }
}
