part of 'match_card_cubit.dart';

class MatchCardState {
  bool isLiked;
  NetworkState networkState;
  String message;

  MatchCardState({this.isLiked=false, this.networkState=NetworkState.INITIAL, this.message});

  MatchCardState copyWith(
     { bool isLiked, NetworkState networkState, String message}) {
    return MatchCardState(
        isLiked: isLiked ?? this.isLiked,
        networkState: networkState ?? this.networkState,
        message: message ?? this.message);
  }
}
