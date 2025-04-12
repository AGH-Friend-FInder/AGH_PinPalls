import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'service.dart';

class UserProvider with ChangeNotifier {
  final Service _service = Service();
  final Logger _logger = Logger(); // Create a logger instance
  Map<String, dynamic> _user = {};

  Map<String, dynamic> get user => _user;

  Future<void> fetchUserById(int id) async {
    try {
      _user = await _service.getUserById(id);
      notifyListeners();
    } catch (e) {
      _logger.e('Error fetching user: $e'); // Log the error
    }
  }

  Future<void> createUser(Map<String, dynamic> user) async {
    try {
      await _service.createUser(user);
      notifyListeners();
    } catch (e) {
      if (e is http.Response && e.statusCode == 400) {
        throw Exception(json.decode(e.body)['message'] ?? 'Registration error');
      }
      _logger.e('Error creating user: $e');
      throw Exception('Failed to register user');
    }
  }
}

class GroupProvider with ChangeNotifier {
  final Service _service = Service();
  final Logger _logger = Logger(); // Create a logger instance
  List<Map<String, dynamic>> _groups = [];

  List<Map<String, dynamic>> get groups => _groups;

  Future<void> fetchPublicGroups() async {
    try {
      _groups = await _service.getPublicGroups();
      notifyListeners();
    } catch (e) {
      _logger.e('Error fetching groups: $e'); // Log the error
    }
  }

  Future<void> fetchGroupById(int id) async {
    try {
      Map<String, dynamic> group = await _service.getGroupById(id);
      _groups = [group];
      notifyListeners();
    } catch (e) {
      _logger.e('Error fetching group: $e'); // Log the error
    }
  }
}
