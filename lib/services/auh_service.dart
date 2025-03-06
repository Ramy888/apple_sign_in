import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Generate a random string for nonce
  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  // SHA256 hash
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Sign in with Apple
  Future<UserCredential?> signInWithApple() async {
    try {
      // Generate nonce
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for Apple Sign In
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create OAuthCredential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in to Firebase with the Apple OAuth credential
      final authResult = await _auth.signInWithCredential(oauthCredential);

      // Update user display name if it's null (first time sign in)
      if (authResult.user != null &&
          authResult.user!.displayName == null &&
          appleCredential.givenName != null) {
        await authResult.user!.updateDisplayName(
            "${appleCredential.givenName} ${appleCredential.familyName}");
      }

      return authResult;
    } catch (e) {
      print('Error during Apple sign in: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}