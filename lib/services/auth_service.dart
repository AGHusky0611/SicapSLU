import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async => await _supabase.auth.signOut();

  Future<String> getUserRole() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return 'Member';

    final data = await _supabase
        .from('profiles')
        .select('roles(title)')
        .eq('id', userId)
        .single();
    return data['roles']['title'] ?? 'Member';
  }
}