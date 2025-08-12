// features/settings_page/widgets/theme_switcher.dart
import 'package:flutter/material.dart';
import 'package:soccer_app/main.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListTile(
        leading: Icon(isDarkTheme ? Icons.dark_mode : Icons.light_mode),
        title: const Text("Theme"),
        trailing: Switch(
          value: isDarkTheme,
          onChanged: (isDark) {
            final newThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
            MyApp.of(context).toggleTheme(newThemeMode);
          },
        ),
      ),
    );
  }
}
