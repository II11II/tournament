import 'dart:convert';

import 'package:tournament/model/player.dart';
import 'package:tournament/model/prize.dart';

class Tournament {
  Tournament({
    this.id,
    this.isFavourite,
    this.players,
    this.matchId,
    this.prizes,
    this.name,
    this.slug,
    this.image,
    this.description,
    this.instructions,
    this.password,
    this.killRevenue,
    this.createdAt,
    this.startAt,
    this.cost,
    this.isPremium,
    this.maxPlayers,
  });

  int id;
  String matchId;
  bool isFavourite;
  List<Player> players;
  List<Prize> prizes;
  String name;
  String slug;
  String image;
  String description;
  String instructions;
  String password;
  num killRevenue;
  DateTime createdAt;
  DateTime startAt;
  num cost;
  bool isPremium;
  int maxPlayers;

  Tournament copyWith({
    String matchId,
    int id,
    bool isFavourite,
    List<Player> players,
    List<Prize> prizes,
    String name,
    String slug,
    String image,
    String description,
    String instructions,
    String password,
    num killRevenue,
    DateTime createdAt,
    DateTime startAt,
    int cost,
    bool isPremium,
    int maxPlayers,
  }) =>
      Tournament(
        matchId: matchId ?? this.matchId,
        isFavourite: isFavourite ?? this.isFavourite,
        id: id ?? this.id,
        players: players ?? this.players,
        prizes: prizes ?? this.prizes,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        description: description ?? this.description,
        instructions: instructions ?? this.instructions,
        password: password ?? this.password,
        killRevenue: killRevenue ?? this.killRevenue,
        createdAt: createdAt ?? this.createdAt,
        startAt: startAt ?? this.startAt,
        cost: cost ?? this.cost,
        isPremium: isPremium ?? this.isPremium,
        maxPlayers: maxPlayers ?? this.maxPlayers,
      );

  factory Tournament.fromRawJson(String str) =>
      Tournament.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      Tournament(
        id: json["id"],
        matchId: json["match_id"],
        isFavourite: json['is_favorite'],
        players:
        List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
        prizes: List<Prize>.from(json["prizes"].map((x) => Prize.fromJson(x))),
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        description: json["description"],
        instructions: json["instructions"],
        password: json["password"],
        killRevenue: json["kill_revenue"],
        createdAt: DateTime.parse(json["created_at"]),
        startAt: DateTime.parse(json["starts_at"]),
        cost: json["cost"],
        isPremium: json["is_premium"],
        maxPlayers: json["max_players"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "match_id":matchId,
        "is_favorite": isFavourite,
        "players": List<dynamic>.from(players.map((x) => x.toJson())),
        "prizes": List<dynamic>.from(prizes.map((x) => x.toJson())),
        "name": name,
        "slug": slug,
        "image": image,
        "description": description,
        "instructions": instructions,
        "password": password,
        "kill_revenue": killRevenue,
        "created_at": createdAt.toIso8601String(),
        "start_at": startAt.toIso8601String(),
        "cost": cost,
        "is_premium": isPremium,
        "max_players": maxPlayers,
      };
}
