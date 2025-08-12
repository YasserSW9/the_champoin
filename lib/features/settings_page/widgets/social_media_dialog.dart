// features/settings_page/widgets/social_media_dialog.dart
import 'package:flutter/material.dart';

void showSocialMediaDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Social Media"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Connect with us on social media",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildSocialMediaItem(
                context,
                icon: Icons.facebook,
                platform: "Facebook",
                onTap: () {
                  print("Navigating to Facebook");
                  Navigator.of(context).pop();
                },
              ),
              _buildSocialMediaItem(
                context,
                icon: Icons.call,
                platform: "WhatsApp",
                onTap: () {
                  print("Navigating to WhatsApp");
                  Navigator.of(context).pop();
                },
              ),
              _buildSocialMediaItem(
                context,
                icon: Icons.telegram,
                platform: "Telegram",
                onTap: () {
                  print("Navigating to Telegram");
                  Navigator.of(context).pop();
                },
              ),
              _buildSocialMediaItem(
                context,
                icon: Icons.photo_camera,
                platform: "Instagram",
                onTap: () {
                  print("Navigating to Instagram");
                  Navigator.of(context).pop();
                },
              ),
              _buildSocialMediaItem(
                context,
                icon: Icons.link_outlined,
                platform: "LinkedIn",
                onTap: () {
                  print("Navigating to LinkedIn");
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _buildSocialMediaItem(
  BuildContext context, {
  required IconData icon,
  required String platform,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 24),
          Expanded(child: Text(platform, style: const TextStyle(fontSize: 16))),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    ),
  );
}
