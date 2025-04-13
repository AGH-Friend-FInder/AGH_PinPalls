import 'dart:convert';
import 'package:agh_pin_palls/groups.dart';
import 'package:agh_pin_palls/models/pin.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class Service {
  final String baseUrl = 'http://10.0.2.2:8080';

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
      throw Exception('Failed to load visible pins');
    }
  }

  Future<Map<String, dynamic>> loginUser(
    String emailOrUsername,
    String password,
  ) async {
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
      return json.decode(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}
