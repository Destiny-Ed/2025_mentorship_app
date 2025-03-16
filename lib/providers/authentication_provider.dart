import 'package:flutter/material.dart';
import 'package:flutter_first_app/service/authentication_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  final authService = AuthenticationService();

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final user = await authService.signInWithEmailAndPassword(emailAddress: email, password: password);
    _isLoading = user.status;
    _message = user.message;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final user = await authService.signUpWithEmailAndPassword(emailAddress: email, password: password);
    _status = user.status;
    _message = user.message;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    final status = await authService.logout();
    _status = status;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> googleAuth() async {
    _isLoading = true;
    notifyListeners();

    final user = await authService.signInWithGoogle();
    _status = user.status;
    _message = user.message;
    _isLoading = false;
    notifyListeners();
  }
}
