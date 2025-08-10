import 'package:flutter/material.dart';
import 'package:soccer_app/features/profile_page/profile_page.dart';
import 'package:soccer_app/main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Champion App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Settings",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: _buildSettingsItem(
                  title: "Profile",
                  icon: Icons.person,
                  trailing: Icons.arrow_forward_ios,
                ),
              ),
              _buildSettingsItem(
                title: "Language",
                subtitle: "AR",
                icon: Icons.language,
                trailing: Icons.arrow_forward_ios,
              ),

              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                  ),
                  title: const Text("Theme"),
                  trailing: Switch(
                    value: isDarkTheme,
                    onChanged: (isDark) {
                      final newThemeMode = isDark
                          ? ThemeMode.dark
                          : ThemeMode.light;
                      MyApp.of(context).toggleTheme(newThemeMode);
                    },
                  ),
                ),
              ),
              _buildSettingsItem(
                title: "Privacy Policy",
                icon: Icons.lock,
                trailing: Icons.arrow_forward_ios,
              ),
              _buildSettingsItem(
                title: "Social Media",
                icon: Icons.share,
                trailing: Icons.arrow_forward_ios,
              ),
              _buildSettingsItem(
                title: "Change Password",
                icon: Icons.lock,
                trailing: Icons.arrow_forward_ios,
              ),
              _buildSettingsItem(
                title: "Delete Account",
                icon: Icons.delete,
                trailing: Icons.arrow_forward_ios,
              ),
              _buildSettingsItem(
                title: "Logout",
                icon: Icons.logout,
                trailing: Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    String? subtitle,
    required IconData icon,
    required IconData trailing,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: Icon(trailing),
      ),
    );
  }
}
