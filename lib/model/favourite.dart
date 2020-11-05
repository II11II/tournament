
import 'dart:convert';

import 'tournament.dart';

class Favourites {
  Favourites({
    this.id,
    this.tournament,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  Tournament tournament;
  DateTime createdAt;
  DateTime updatedAt;

  Favourites copyWith({
    int id,
    Tournament tournament,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Favourites(
        id: id ?? this.id,
        tournament: tournament ?? this.tournament,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Favourites.fromRawJson(String str) => Favourites.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Favourites.fromJson(Map<String, dynamic> json) => Favourites(
    id: json["id"],
    tournament: Tournament.fromJson(json["tournament"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tournament": tournament.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

