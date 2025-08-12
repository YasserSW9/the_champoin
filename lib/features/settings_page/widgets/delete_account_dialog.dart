// features/settings_page/widgets/delete_account_dialog.dart
import 'package:flutter/material.dart';

void showDeleteAccountConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Are you sure ?"),
        content: const Text(
          "Are you sure you want to delete your account? This action cannot be undone.",
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
            onPressed: () {
              print("Account deletion requested.");
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
