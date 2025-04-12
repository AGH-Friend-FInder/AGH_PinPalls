import 'package:flutter/foundation.dart';
import 'service.dart';

class UserProvider with ChangeNotifier {
  final Service _service = Service();
  Map<String, dynamic> _user = {};

  Map<String, dynamic> get user => _user;

  Future<void> fetchUserById(int id) async {
    try {
      _user = await _service.getUserById(id);
      notifyListeners();
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  Future<void> createUser(Map<String, dynamic> user) async {
    try {
      await _service.createUser(user);
      notifyListeners();
    } catch (e) {
      print('Error creating user: $e');
    }
  }
}

class GroupProvider with ChangeNotifier {
  final Service _service = Service();
  List<Map<String, dynamic>> _groups = [];

  List<Map<String, dynamic>> get groups => _groups;

  Future<void> fetchPublicGroups() async {
    try {
      _groups = await _service.getPublicGroups();
      notifyListeners();
    } catch (e) {
      print('Error fetching groups: $e');
    }
  }

  Future<void> fetchGroupById(int id) async {
    try {
      Map<String, dynamic> group = await _service.getGroupById(id);
      _groups = [group];
      notifyListeners();
    } catch (e) {
      print('Error fetching group: $e');
    }
  }
}
