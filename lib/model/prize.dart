
import 'dart:convert';

class Prize {
  Prize({
    this.url,
    this.name,
    this.icon,
    this.price,
  });

  String url;
  String name;
  String icon;
  double price;

  Prize copyWith({
    String url,
    String name,
    String icon,
    double price,
  }) =>
      Prize(
        url: url ?? this.url,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        price: price ?? this.price,
      );

  factory Prize.fromRawJson(String str) => Prize.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Prize.fromJson(Map<String, dynamic> json) => Prize(
    url: json["url"],
    name: json["name"],
    icon: json["icon"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "name": name,
    "icon": icon,
    "price": price,
  };
}