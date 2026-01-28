class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: orgCoreTheme,
      home: StreamBuilder<AuthState>(
        stream: supabase.auth.onAuthStateChange,
        builder: (context, snapshot) {
          final session = snapshot.data?.session;

          // If no session ID/JWT, show Login
          if (session == null) {
            return OrgCoreLoginPage();
          }

          // If logged in, show the Dashboard Shell
          return DashboardShell(user: session.user);
        },
      ),
    );
  }
}