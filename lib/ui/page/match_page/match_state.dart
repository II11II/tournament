part of 'match_cubit.dart';

class MatchState {
  Payment payment;
  bool isLiked;
  NetworkState networkState;
  String message;
  String amount;
  CheckCard card;
  Tournament tournament;
  final List<String> nameTournament = ["per_kill", "top_10", "winner_gets"];
  bool isInstructionExpanded;
  bool isDescriptionExpanded;

  MatchState(this.tournament,
      {this.card,
      this.payment = Payment.PAY_ME,
      this.networkState = NetworkState.INITIAL,
      this.isLiked = false,
      this.amount,
      this.message,
      this.isDescriptionExpanded = false,
      this.isInstructionExpanded = false});

  MatchState copyWith({
    CheckCard card,
    String amount,
    Tournament tournament,
    Payment payment,
    String message,
    NetworkState networkState,
    bool isLiked,
    bool isInstructionExpanded,
    bool isDescriptionExpanded,
  }) {
    return MatchState(tournament ?? this.tournament,
        card: card ?? this.card,
        amount: amount??this.amount,
        isLiked: isLiked ?? this.isLiked,
        message: message ?? this.message,
        networkState: networkState ?? this.networkState,
        isDescriptionExpanded:
            isDescriptionExpanded ?? this.isDescriptionExpanded,
        isInstructionExpanded:
            isInstructionExpanded ?? this.isInstructionExpanded,
        payment: payment ?? this.payment);
  }
}

enum Payment { PAY_ME, CLICK }
