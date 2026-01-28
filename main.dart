import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with your project credentials
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
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
      theme: SicapTheme.lightTheme, // Uses the theme we built earlier
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // This listener automatically rebuilds the UI when the session changes
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final session = snapshot.data?.session;

        // If no session exists, show the login screen
        if (session == null) {
          return const SicapLoginPage();
        }

        // If logged in, show the Dashboard Shell (which we'll build next)
        return const DashboardShell();
      },
    );
  }
}

// Temporary placeholder for your Modular Dashboard
class DashboardShell extends StatelessWidget {
  const DashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SICAP Dashboard")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => AuthService().signOut(),
          child: const Text("Sign Out"),
        ),
      ),
    );
  }
}