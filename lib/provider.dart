import 'package:agh_pin_palls/groups.dart';
import 'package:agh_pin_palls/models/pin.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'service.dart';
import 'user.dart';

class UserProvider with ChangeNotifier {
  final Service _service = Service();
  final Logger _logger = Logger(); // Create a logger instance
  Map<String, dynamic> _user = {};
  User? _user2;

  Map<String, dynamic> get user => _user;
  User? get user2 => _user2;

  Future<void> fetchUserById() async {
    try {
      _user2 = await _service.getUserById(user['id'].toInt());
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
      _logger.e('Error creating user: $e');
      if (e is http.Response && e.statusCode == 400) {
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  Future<void> loginUser(String emailOrUsername, String password) async {
    try {
      _user = await _service.loginUser(emailOrUsername, password);
      notifyListeners();
    } catch (e) {
      _logger.e('Error logging in: $e');
      rethrow;
    }
  }
}

class GroupProvider with ChangeNotifier {
  final Service _service = Service();
  final Logger _logger = Logger(); // Create a logger instance
  List<Group> _userGroups = [];
  List<Group> _publicGroups = [];

  List<Group> get userGroups => _userGroups;
  List<Group> get publicGroups => _publicGroups;

  Future<void> fetchPublicGroups() async {
    try {
      _publicGroups = await _service.getPublicGroups();
      notifyListeners();
    } catch (e) {
      _logger.e('Error fetching groups: $e'); // Log the error
    }
  }

  Future<void> fetchGroupsFromUserId(int userId) async {
    try {
      _userGroups = await _service.getUserGroups(userId);
      notifyListeners();
    } catch (e) {
      _logger.e('Error fetching tags: $e'); // Log the error
    }
  }

  // Future<void> fetchGroupById(int id) async {
  //   try {
  //     Map<String, dynamic> group = await _service.getGroupById(id);
  //     _groups = [group];
  //     notifyListeners();
  //   } catch (e) {
  //     _logger.e('Error fetching group: $e'); // Log the error
  //   }
  // }
}

class PinProvider with ChangeNotifier {
  final Service _service = Service();
  final Logger _logger = Logger(); // Create a logger instance
  List<Pin> _pins = [];

  List<Pin> get pins => _pins;

  Future<void> fetchVisiblePins(int userId) async {
    try {
      _pins = await _service.getVisiblePins(userId);
      notifyListeners();
    } catch (e) {
      _logger.e('Error fetching pins: $e'); // Log the error
    }
  }

  Future<void> fetchMyGroups(int? id) async {
    try {
      if (id != null) {
        List<Map<String, dynamic>> groups = await _service.getMyGroups(id);
        _mygroups = groups;
      }
      notifyListeners();
    } catch (e) {
      _logger.e('Error fetching group: $e'); // Log the error
    }
  }
}
