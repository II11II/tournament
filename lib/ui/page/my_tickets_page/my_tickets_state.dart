part of 'my_tickets_cubit.dart';

class MyTicketsState {
  List<Favourites> myTickets;
  NetworkState state;
  String message;

  MyTicketsState({this.myTickets, this.state, this.message});

  MyTicketsState copyWith(
      {List<Favourites> myTickets, String message, NetworkState state}) {
    return MyTicketsState(
        myTickets: myTickets ?? this.myTickets,
        state: state ?? this.state,
        message: message ?? this.message);
  }
}
