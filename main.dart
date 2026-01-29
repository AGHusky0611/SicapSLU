import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import our internal project structure
import 'lib/core/constants/api_constants.dart';
import 'lib/core/theme/app_theme.dart';
import 'lib/features/auth/screens/login_screen.dart';
import 'lib/features/dashboard/screens/dashboard_shell.dart';

void main() async {
  // Ensure Flutter engine is ready before calling asynchronous code
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with the credentials from your Constants file
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
      // Apply our organization's custom branding/theme
      theme: SicapTheme.lightTheme,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    /* StreamBuilder is the "heart" of your navigation. 
      It watches the Supabase Auth state in real-time.
    */
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Show a loading spinner while the app checks for an existing login session
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.data?.session;

        // Decision Logic:
        // 1. If no valid session (JWT) is found, show the Login Card.
        if (session == null) {
          return const SicapLoginPage();
        }

        // 2. If a session is valid, send them directly to the Sidebar Dashboard.
        return const DashboardShell();
      },
    );
  }
}