import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _auth.currentUser;
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;

  // Login method
  Future<void> login(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    } finally {
      _setLoading(false);
    }
  }

  // Register method
  Future<void> register(String email, String password, String username) async {
    try {
      _setLoading(true);
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // Create user document in Firestore
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'username': username,
        'email': email,
        'createdAt': Timestamp.now(),
        'profileImage': '',
        'membership': 'basic',
        'favoriteArtists': ['ENHYPEN']
      });
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    } finally {
      _setLoading(false);
    }
  }

  // Password reset method
  Future<void> resetPassword(String email) async {
    try {
      _setLoading(true);
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    } finally {
      _setLoading(false);
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      throw 'Logout failed: $e';
    }
  }

  // Error handler
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Email address is invalid';
      case 'user-disabled':
        return 'This user has been disabled';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}