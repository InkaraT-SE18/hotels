import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<User?> signUpWithEmail(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: '1SNIrlzX54rcl6EZ1UC9T9aYi',
      apiSecretKey: '7qqq2S1zhHSjlhlwWkFIGqM6l9gMeGSbwoIaqnZwLDVqCknX2W',
      redirectURI: 'https://hotel-booking-873b8.firebaseapp.com/__/auth/handler', 
    );

    final authResult = await twitterLogin.login();

    if (authResult.status == TwitterLoginStatus.loggedIn) {
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      final userCredential = await _auth.signInWithCredential(twitterAuthCredential);
      return userCredential.user;
    }

    return null;
  }
}
