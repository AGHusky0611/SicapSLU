import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // 1. SIGN IN logic
  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // 2. SIGN UP logic (Everyone defaults to 'Member' via our SQL Trigger)
  Future<AuthResponse> signUp(String email, String password, String fullName) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName}, // Passed to our SQL Trigger
    );
  }

  // 3. SIGN OUT logic
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // 4. Get Current User Session (JWT)
  Session? get currentSession => _supabase.auth.currentSession;

  // 5. Fetch the User's Role from our Profiles table
  Future<String> getUserRole() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return 'Guest';

    final data = await _supabase
        .from('profiles')
        .select('roles(title)')
        .eq('id', userId)
        .single();

    return data['roles']['title'] ?? 'Member';
  }
}