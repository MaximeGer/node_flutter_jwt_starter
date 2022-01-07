import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constants.dart';
import 'package:http/http.dart';
import '../models/cities.dart';

const storage = FlutterSecureStorage();
// --------------- Authentication Collection ---------------
Future<bool> isLogged() async {
  var jwt = await getJwt();
  if (jwt != null) {
    return true;
  } else {
    return false;
  }
}

Future<String> login(String email, String password) async {
  if (email.isEmpty || password.isEmpty) {
    return "You must use a valid email";
  }
  final response = await post(Uri.parse("$apiUrl/auth/login"),
      headers: {
        "workout-api-key": apiKey,
        "Content-Type": "application/json",
        "accept": "application/json"
      },
      body: jsonEncode({"email": email, "password": password}));
  var responseBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    await storage.write(key: "jwt", value: responseBody["token"]);
    return "connected";
  } else {
    if (responseBody["message"] != null) {
      return responseBody["message"];
    } else {
      return responseBody["error"];
    }
  }
}

Future<String> signin(String email, String password) async {
  if (email.isEmpty || password.isEmpty) {
    return "You must use a valid email";
  }
  final response = await post(Uri.parse("$apiUrl/auth/sign-in"),
      headers: {
        "workout-api-key": apiKey,
        "Content-Type": "application/json",
        "accept": "application/json"
      },
      body: jsonEncode({"email": email, "password": password}));
  var responseBody = jsonDecode(response.body);
  if (response.statusCode == 201) {
    return await login(email, password);
  } else {
    if (responseBody["message"] != null) {
      return responseBody["message"];
    } else {
      return responseBody["error"];
    }
  }
}

Future<void> logout() async {
  await storage.delete(key: "jwt");
}

Future<String?> getJwt() async {
  String? jwt = await storage.read(key: "jwt");

  if (jwt != null) {
    print(jwt);

    // if not expired
    return jwt;
    // else
    // storage.delete jwt
    // return null
  } else {
    print("jwt = null");
    return null; // no JWT
  }
}

// --------------- Workout Data Fetch Collection ---------------

Future<List<City>> fetchCities() async {
  var jwt = await getJwt();
  if (jwt == null) {
    throw Exception("You must be authenticated to see this");
  }
  final response = await get(Uri.parse("$apiUrl/Cities"),
      headers: {HttpHeaders.authorizationHeader: "Bearer $jwt"});

  if (response.statusCode == 200) {
    List<City> cities = [];
    for (var exercise in jsonDecode(response.body)) {
      cities.add(City.fromJson(exercise));
    }
    return cities;
  } else {
    throw Exception('Failed to load cities');
  }
}
