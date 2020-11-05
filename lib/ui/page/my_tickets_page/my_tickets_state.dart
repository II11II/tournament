part of 'my_tickets_cubit.dart';

class MyTicketsState {
  List<Ticket> myTickets;
  NetworkState state;
  String message;

  MyTicketsState({this.myTickets, this.state, this.message});

  MyTicketsState copyWith(
      {List<Ticket> myTickets, String message, NetworkState state}) {
    return MyTicketsState(
        myTickets: myTickets ?? this.myTickets,
        state: state ?? this.state,
        message: message ?? this.message);
  }
}
