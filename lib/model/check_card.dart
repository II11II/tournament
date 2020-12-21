import 'dart:convert';

class CheckCard {
    CheckCard({
        this.jsonrpc,
        this.result,
        this.token,
    });

    String jsonrpc;
    Result result;
    String token;

    factory CheckCard.fromRawJson(String str) => CheckCard.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CheckCard.fromJson(Map<String, dynamic> json) => CheckCard(
        jsonrpc: json["jsonrpc"],
        result: Result.fromJson(json["result"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "result": result.toJson(),
        "token": token,
    };
}

class Result {
    Result({
        this.sent,
        this.phone,
        this.wait,
    });

    bool sent;
    String phone;
    int wait;

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        sent: json["sent"],
        phone: json["phone"],
        wait: json["wait"],
    );

    Map<String, dynamic> toJson() => {
        "sent": sent,
        "phone": phone,
        "wait": wait,
    };
}