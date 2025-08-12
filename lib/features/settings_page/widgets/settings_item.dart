// features/settings_page/widgets/settings_item.dart
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final IconData trailing;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle.toString()) : null,
          trailing: Icon(trailing),
        ),
      ),
    );
  }
}
