import 'package:flutter/material.dart';
import 'package:hw_4/src/controllers/application_controller.dart';
import 'package:hw_4/src/models/user.dart';
import 'package:hw_4/src/services/auth.dart';

class AuthController extends ApplicationController {
  String email;
  String password;
  String passwordConfirmation;
  bool passwordConfirmed;
  bool showLogin;
  bool authInProgress;
  String _validationErrorMessage;
  AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  static final AuthController _authController = AuthController._internal();

  factory AuthController({ StateUpdater setState }) {
    _authController.setState = setState;
    _authController.authInProgress = false;
    _authController.email = '';
    _authController.password = '';
    _authController.passwordConfirmation = '';
    _authController.passwordConfirmed = false;
    _authController.showLogin = true;
    _authController._validationErrorMessage = '';

    return _authController;
  }

  AuthController._internal();


  void _handleEmailChange() {
    this.email = this.emailController.text.trim();
  }

  void _handlePasswordChange() {
    this.password = this.passwordController.text.trim();
  }

  void _handlePasswordConfirmationChange() {
    this.passwordConfirmation = this.passwordConfirmationController.text.trim();
  }

  bool _validateEmail() {
    return this.emailController.text.isNotEmpty;
  }

  bool _validatePassword() {
    bool passwordIsValid = this.passwordController.text.isNotEmpty;
    if (this.showLogin) {
      return passwordIsValid;
    } else {
      return passwordIsValid && this.passwordController.text == this.passwordConfirmationController.text;
    }
  }

  void authenticateUser() async {
    if (!this._validateEmail()) return;
    if (!this._validatePassword()) return;

    this._handleEmailChange();
    this._handlePasswordChange();
    this._handlePasswordConfirmationChange();

    this.setState(() {
      this.authInProgress = true;
    });
    User user = this.showLogin
      ? await this._authService.signInWithEmailAndPassword(email: this.email, password: this.password)
      : await this._authService.signUpWithEmailAndPassword(email: this.email, password: this.password);
    if (user == null) {
      this.setState(() {
        this._validationErrorMessage = this._authService.popError();
        this.authInProgress = false;
      });
    } else {
      this.setState(() {
        this._validationErrorMessage = '';
        this.authInProgress = false;
      });
      this.emailController.clear();
      this.passwordController.clear();
      this.passwordConfirmationController.clear();
    }
  }

  String get validationErrorMessage {
    final String message = this._validationErrorMessage;
    this._validationErrorMessage = '';
    return message;
  }

  bool get validationErrorsPresent {
    return this._validationErrorMessage.isNotEmpty;
  }

  void showLoginForm() {
    super.setState(() {
      this.showLogin = true;
    });
  }

  void showRegisterForm() {
    super.setState(() {
      this.showLogin = false;
    });
  }

  String onEditPassword(String password) {
    super.setState(() {
      if (this.passwordController.text == this.passwordConfirmationController.text) {
        this.passwordConfirmed = true;
      } else {
        this.passwordConfirmed = false;
      }
    });
    return password;
  }
}
