// features/settings_page/settings_page.dart
import 'package:flutter/material.dart';
import 'package:soccer_app/features/change_password_page/change_password_page.dart';
import 'package:soccer_app/features/profile_page/profile_page.dart';
import 'package:soccer_app/features/settings_page/widgets/delete_account_dialog.dart';
import 'package:soccer_app/features/settings_page/widgets/privacy_policy_dialog.dart';
import 'package:soccer_app/features/settings_page/widgets/settings_item.dart';
import 'package:soccer_app/features/settings_page/widgets/social_media_dialog.dart';
import 'package:soccer_app/features/settings_page/widgets/theme_switcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Champion App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Settings",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              // Profile
              SettingsItem(
                title: "Profile",
                icon: Icons.person,
                trailing: Icons.arrow_forward_ios,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),

              // Language
              const SettingsItem(
                title: "Language",
                subtitle: "AR",
                icon: Icons.language,
                trailing: Icons.arrow_forward_ios,
              ),

              // Theme
              const ThemeSwitcher(),

              // Privacy Policy
              SettingsItem(
                title: "Privacy Policy",
                icon: Icons.lock,
                trailing: Icons.arrow_forward_ios,
                onTap: () {
                  showPrivacyPolicy(context);
                },
              ),

              // Social Media
              SettingsItem(
                title: "Social Media",
                icon: Icons.share,
                trailing: Icons.arrow_forward_ios,
                onTap: () {
                  showSocialMediaDialog(context);
                },
              ),

              // Change Password
              SettingsItem(
                title: "Change Password",
                icon: Icons.lock,
                trailing: Icons.arrow_forward_ios,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(),
                    ),
                  );
                },
              ),

              // Delete Account
              SettingsItem(
                title: "Delete Account",
                icon: Icons.delete,
                trailing: Icons.arrow_forward_ios,
                onTap: () {
                  showDeleteAccountConfirmation(context);
                },
              ),

              // Logout
              SettingsItem(
                title: "Logout",
                icon: Icons.logout,
                trailing: Icons.arrow_forward_ios,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const login(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
