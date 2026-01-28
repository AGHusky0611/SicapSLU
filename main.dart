import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/api_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: ApiConstants.supabaseUrl,
    anonKey: ApiConstants.supabaseAnonKey,
  );

  runApp(const SicapApp());
}

class SicapApp extends StatelessWidget {
  const SicapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SICAP Portal',
      debugShowCheckedModeBanner: false,
      theme: SicapTheme.lightTheme,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final session = snapshot.data?.session;

        // Redirect to login if no session exists
        if (session == null) {
          return const SicapLoginPage();
        }

        // Proceed to dashboard if authenticated
        return const Scaffold(body: Center(child: Text("Welcome to SICAP Dashboard")));
      },
    );
  }
}