part of 'favourite_tournament_cubit.dart';

class FavouriteTournamentState {
  List<Favourites> favouriteTournaments;
  NetworkState networkState;
  String message;

  FavouriteTournamentState(
      {this.favouriteTournaments, this.networkState, this.message});

  FavouriteTournamentState copyWith({List<Favourites> favouriteTournaments,
      NetworkState networkState, String message}) {
    return FavouriteTournamentState(
        message: message ?? this.message,
        networkState: networkState ?? this.networkState,
        favouriteTournaments:
            favouriteTournaments ?? this.favouriteTournaments);
  }
}
