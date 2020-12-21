import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/model/check_card.dart';
import 'package:tournament/model/favourite.dart';
import 'package:tournament/model/player.dart';
import 'package:tournament/model/tournament.dart';
import 'package:tournament/repository/repository.dart';

mixin Network {
  /// Base url
  static const String _url = "http://165.227.158.48:8000";

  /// Get Token from cache and pass to header
  Future<Map<String, String>> _header() async {
    String userToken = await Repository.instance.getUserToken();
    return {"Authorization": "Token $userToken"};
  }

  /// Requests
  Future<String> login(String email, String password) async {
    var body = {
      "username": email,
      "password": password,
    };
    http.Response response =
        await http.post("$_url/api/accounts/login/", body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['key'];
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw InvalidLoginPasswordException(response.body);
    } else
      throw ServerErrorException(response.body);
  }

  Future<void> registration(
      String username, String password, String email) async {
    var body = {
      "username": username,
      "email": email,
      "password1": password,
      "password2": password
    };
    http.Response response =
        await http.post("$_url/api/accounts/registration/", body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else if (response.statusCode == 400) {
      throw UserExistException(response.body);
    } else {
      throw ServerErrorException(response.body);
    }
  }

  Future<bool> verifyByEmail(String key) async {
    var body = {"key": key};
    http.Response response = await http
        .post("$_url/api/accounts/registration/verify-email/", body: body);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw InvalidCodeException(response.body);
    } else {
      throw ServerErrorException(response.body);
    }
  }

  Future logout() async {
    http.Response response = await http.post(
      "$_url/api/accounts/logout/",
    );
    if (response.statusCode == 200) {
    } else if (response.statusCode == 401) {
    } else if (response.statusCode == 403) {
    } else {
      throw ServerErrorException(response.body);
    }
  }

  Future changePassword(String password) async {
    var body = {"new_password1": password, "new_password2": password};
    http.Response response = await http.post(
        "$_url/api/accounts/password/change/",
        body: body,
        headers: await _header());
    if (response.statusCode == 200) {
    } else if (response.statusCode == 401) {
      InvalidTokenException(response.body);
    } else
      throw ServerErrorException(response.body);
  }

  Future resetPassword(String email) async {
    var body = {"email": email};
    http.Response response =
        await http.post("$_url/api/accounts/password/reset/", body: body);

    if (response.statusCode == 200) {}
    if (response.statusCode == 401) {
      InvalidTokenException(response.body);
    } else
      throw ServerErrorException(response.body);
  }

  Future<List<Tournament>> premiumTournaments() async {
    http.Response response = await http.get("$_url/api/tournament/premium/",
        headers: await _header());

    if (response.statusCode == 200) {
      List tournament = json.decode(response.body);
      return List<Tournament>.from(
          tournament.map((e) => Tournament.fromJson(e)));
    }
    if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else
      throw ServerErrorException(response.body);
  }

  Future<List<Tournament>> todayTournaments() async {
    http.Response response =
        await http.get("$_url/api/tournament/today/", headers: await _header());

    if (response.statusCode == 200) {
      List tournament = json.decode(response.body);
      return List<Tournament>.from(
          tournament.map((e) => Tournament.fromJson(e)));
    }
    if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else
      throw ServerErrorException(response.body);
  }

  Future<List<Tournament>> upcomingTournaments() async {
    http.Response response = await http.get("$_url/api/tournament/upcoming/",
        headers: await _header());

    if (response.statusCode == 200) {
      List tournament = json.decode(response.body);
      return List<Tournament>.from(
          tournament.map((e) => Tournament.fromJson(e)));
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else
      throw ServerErrorException(response.body);
  }

  Future<List<Favourites>> tickets() async {
    http.Response response =
        await http.get("$_url/api/ticket/", headers: await _header());

    if (response.statusCode == 200) {
      List tournament = json.decode(response.body);
      return List<Favourites>.from(
          tournament.map((e) => Favourites.fromJson(e)));
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else
      throw ServerErrorException(response.body);
  }

  Future player() async {
    http.Response response =
        await http.get("$_url/api/accounts/user/", headers: await _header());

    if (response.statusCode == 200) {
      return Player.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else
      throw ServerErrorException(response.body);
  }

  Future<List<Favourites>> favouritesTournaments() async {
    http.Response response =
        await http.get("$_url/api/favorites/", headers: await _header());

    if (response.statusCode == 200) {
      return List.from(
          jsonDecode(response.body).map((json) => Favourites.fromJson(json)));
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else if (response.statusCode >= 500) {
      throw ServerErrorException(response.body);
    } else
      throw Exception(response.body);
  }

  Future<void> toFavourite(int tournamentId) async {
    http.Response response = await http.post(
        "$_url/api/tournament/favorite/$tournamentId/",
        headers: await _header());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else if (response.statusCode >= 500) {
      throw ServerErrorException(response.body);
    } else
      throw Exception([response.statusCode, response.body]);
  }

  Future<CheckCard> checkCard(
      String cardNumber, String expireDate, String amount) async {
    var body = {
      "card_number": cardNumber,
      "exp_date": expireDate,
      "amount": amount,
    };

    http.Response response = await http.post("$_url/api/accounts/cc/",
        headers: await _header(), body: body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      Logger().d(response.body);
      Map result = jsonDecode(utf8.decode(response.body.runes.toList()));
      if (result.containsKey("error"))
        throw InvalidCardCredentialsException(result["error"]);
      else
        return  CheckCard.fromJson(result);
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else if (response.statusCode >= 500) {
      throw ServerErrorException(response.body);
    } else
      throw Exception([response.statusCode, response.body]);
  }

  Future<void> checkSmsCode(
      String code, String cardToken, String amount) async {
    var body = {
      "code": code,
      "token": cardToken,
      "amount": amount,
    };
    http.Response response = await http.post("$_url/api/accounts/cc/verify",
        headers: await _header(), body: body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      

      Map result = jsonDecode(utf8.decode(response.body.runes.toList()));
      if (result.containsKey("error"))
        throw InvalidCardCredentialsException(result["error"]);
      else
        return;
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(response.body);
    } else if (response.statusCode >= 500) {
      throw ServerErrorException(response.body);
    } else
      throw Exception([response.statusCode, response.body]);
  }
}
