import 'dart:convert';
import 'package:agh_pin_palls/models/pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'models/user.dart';
import 'models/group.dart';

class Service {
  final String baseUrl = 'https://server-production-65c0.up.railway.app';

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<Group>> getPublicGroups() async {
    final response = await http.get(Uri.parse('$baseUrl/groups/public'));
    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Group>.from(jsonList.map((json) => Group.fromJson(json)));
    } else {
      throw Exception('Failed to load public groups');
    }
  }

  Future<List<Map<String, dynamic>>> getMyGroups(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/group/$id'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load public groups');
    }
  }

  Future<void> createUser(Map<String, dynamic> user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user),
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<Map<String, dynamic>> getGroupById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/groups/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<Group>> getUserGroups(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/group/$userId'));
    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Group>.from(jsonList.map((json) => Group.fromJson(json)));
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<Pin>> getVisiblePins(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/pin/visible/$userId'));
    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Pin>.from(jsonList.map((json) => Pin.fromJson(json)));
    } else {
      debugPrint('Failed to load visible pins: ${response.body}');
      throw Exception('Failed to load visible pins');
    }
  }

  Future<void> postNewPin(Pin pin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pin.toJson()),
    );
    if (response.statusCode != 200) {
      debugPrint('Failed to create pin: ${response.body}');
      throw Exception('Failed to create pin');
    }
  }

  Future<User> loginUser(String emailOrUsername, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': emailOrUsername.contains('@') ? emailOrUsername : null,
        'username': emailOrUsername.contains('@') ? null : emailOrUsername,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> updateGroups(List<Group> newGroups, int? userId) async {
    for (final group in newGroups) {
      int groupId = group.id;
      final response = await http.post(
        Uri.parse('$baseUrl/users/$userId/$groupId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    }
  }
}
