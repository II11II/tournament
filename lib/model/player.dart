import 'dart:convert';

import 'package:tournament/model/favourite.dart';

class Player {
  Player({
    this.url,
    this.backgroundImage,
    this.id,
    this.firstName,
    this.username,
    this.email,
    this.image,
    this.balance,
    this.revenue,
    this.matches,
    this.pubgId,

  });


  String url;
  String backgroundImage;
  int id;
  String firstName;
  String username;
  String email;
  String pubgId;
  String image;
  double balance;
  num revenue;
  int matches;

  Player copyWith({

    String url,
    String pubgId,
    int id,
    String backgroundImage,
    String firstName,
    String username,
    String email,
    String image,
    int balance,
    int revenue,
    int matches,
  }) =>
      Player(

        pubgId: pubgId ?? this.pubgId,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        url: url ?? this.url,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        username: username ?? this.username,
        email: email ?? this.email,
        image: image ?? this.image,
        balance: balance ?? this.balance,
        revenue: revenue ?? this.revenue,
        matches: matches ?? this.matches,
      );

  factory Player.fromRawJson(String str) => Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(

        url: json["url"],
        pubgId: json["pubg_id"],
        backgroundImage: json["background_image"],
        id: json["id"],
        firstName: json["first_name"],
        username: json["username"],
        email: json["email"],
        image: json["image"],
        balance: json["balance"],
        revenue: json["revenue"],
        matches: json["matches"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "background_image": backgroundImage,
        "id": id,

        "pubg_id": pubgId,
        "first_name": firstName,
        "username": username,
        "email": email,
        "image": image,
        "balance": balance,
        "revenue": revenue,
        "matches": matches,
      };
}
