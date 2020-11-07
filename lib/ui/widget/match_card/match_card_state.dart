part of 'match_card_cubit.dart';

class MatchCardState {
  bool isLiked;
  NetworkState networkState;
  String message;
  String titleButton;
  MatchCardState({this.isLiked=false, this.networkState=NetworkState.INITIAL, this.message,this.titleButton});

  MatchCardState copyWith(
     { bool isLiked, NetworkState networkState, String message,String titleButton}) {
    return MatchCardState(
      titleButton: titleButton??this.titleButton,
        isLiked: isLiked ?? this.isLiked,
        networkState: networkState ?? this.networkState,
        message: message ?? this.message);
  }
}
