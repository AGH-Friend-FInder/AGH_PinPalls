import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);
  return hash.toString();
}

bool verifyPassword(String inputPassword, String storedHash) {
  final inputHash = hashPassword(inputPassword);
  return inputHash == storedHash;
}
