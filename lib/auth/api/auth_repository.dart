import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef _) => AuthRepository();

class AuthRepository {
  final _client = Supabase.instance.client;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"],
    serverClientId: dotenv.env['GOOGLE_CLIENT_ID'] ?? '',
  );

  Stream<AuthState> get authState => _client.auth.onAuthStateChange;

  Future<AuthResponse> logIn() async {
    final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuthentication = await googleAccount!.authentication;
    final accessToken = googleAuthentication.accessToken;
    final idToken = googleAuthentication.idToken;
    if (kDebugMode) {
      print(googleAccount);
      print(googleAuthentication);
      print(accessToken);
      print(idToken);
    }

    final user = await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken ?? '',
      accessToken: accessToken,
    );

    if (kDebugMode) {
      print('supabase user');
      print(user.user?.toJson());
    }

    return user;
  }

  Future<void> logout() async {
    _client.auth.signOut();
    _googleSignIn.signOut();
  }
}
