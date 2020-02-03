import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_flutter/providers/authentication_provider.dart';
import 'package:learn_flutter/providers/base_providers.dart';

class AuthenticationRepository {
  BaseAuthenticationProvider authenticationProvider = AuthenticationProvider();

  Future<FirebaseUser> signInWithGoogle() =>
      authenticationProvider.signInWithGoogle();

  Future<void> signOutUser() => authenticationProvider.signOutUser();

  Future<FirebaseUser> getCurrentUser() =>
      authenticationProvider.getCurrentUser();

  Future<bool> isLoggedIn() => authenticationProvider.isLoggedIn();
}