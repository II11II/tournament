part of 'home_cubit.dart';

class HomeState {
  bool logout = false;
  bool aboutApp = false;
  List<Tournament> todayTournaments;
  List<Tournament> upcomingTournaments;
  List<Tournament> premiumTournaments;
  NetworkState networkState;
  String message;

  HomeState(
      {this.logout,
        this.todayTournaments,
     this.upcomingTournaments,
      this.networkState = NetworkState.INITIAL,
      this.message,
      this.premiumTournaments});

  HomeState copyWith(
      {bool logout,
        List<Tournament> upcomingTournaments,
      List<Tournament> todayTournaments,
      NetworkState networkState,
      List<Tournament> premiumTournaments,

      String message}) {
    return HomeState(
        premiumTournaments: premiumTournaments ?? this.premiumTournaments,
        todayTournaments: todayTournaments ?? this.todayTournaments,
        upcomingTournaments: upcomingTournaments ?? this.upcomingTournaments,
        networkState: networkState ?? this.networkState,
        message: message ?? this.message,
        logout: logout ?? this.logout);
  }
}
