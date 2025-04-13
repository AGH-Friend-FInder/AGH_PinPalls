import 'package:agh_pin_palls/models/pin.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'service.dart';
import 'models/user.dart';
import 'models/group.dart';

class UserProvider with ChangeNotifier {
  final Service _service = Service();
  final Logger _logger = Logger(); // Create a logger instance
  User? _user;

  User? get user => _user;

  Future<void> fetchUserById() async {
    try {
      _user = await _service.getUserById(_user!.id);
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

  Future<void> fetchGroupsFromUserId(int? userId) async {
    try {
      if (userId != null) {
        _userGroups = await _service.getUserGroups(userId);
      }
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
}
