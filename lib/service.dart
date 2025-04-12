import 'dart:convert';
import 'package:http/http.dart' as http;

class Service {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<Map<String, dynamic>> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<Map<String, dynamic>>> getPublicGroups() async {
    final response = await http.get(Uri.parse('$baseUrl/groups/public'));
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
      throw Exception('Failed to create user');
    }
  }

  Future<Map<String, dynamic>> getGroupById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/groups/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load group');
    }
  }
}
