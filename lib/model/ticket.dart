
import 'dart:convert';

class Ticket {
  Ticket({
    this.url,
    this.cost,
    this.player,
    this.tournament,
  });

  String url;
  num cost;
  String player;
  String tournament;

  Ticket copyWith({
    String url,
    num cost,
    String player,
    String tournament,
  }) =>
      Ticket(
        url: url ?? this.url,
        cost: cost ?? this.cost,
        player: player ?? this.player,
        tournament: tournament ?? this.tournament,
      );

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    url: json["url"],
    cost: json["cost"],
    player: json["player"],
    tournament: json["tournament"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "cost": cost,
    "player": player,
    "tournament": tournament,
  };
}
