// features/settings_page/widgets/privacy_policy_dialog.dart
import 'package:flutter/material.dart';

void showPrivacyPolicy(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Privacy Policy"),
        content: const SingleChildScrollView(
          child: Text("""
This Privacy Policy governs the manner in which our app, Champion App, collects, uses, maintains, and discloses information collected from users (each, a "User") of the Champion App mobile application ("App"). This privacy policy applies to the App and all products and services offered by our app.

Personal identification information
We may collect personal identification information from Users in a variety of ways, including, but not limited to, when Users visit our App, register on the App, and in connection with other activities, services, features or resources we make available on our App. Users may be asked for, as appropriate, name, email address, phone number. Users may, however, visit our App anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personal identification information, except that it may prevent them from engaging in certain App related activities.

Non-personal identification information
We may collect non-personal identification information about Users whenever they interact with our App. Non-personal identification information may include the browser name, the type of computer and technical information about Users' means of connection to our App, such as the operating system and the Internet service providers utilized and other similar information.

How we use collected information
Our app may collect and use Users personal information for the following purposes:
- To improve customer service
- To personalize user experience
- To improve our App
- To send periodic emails

How we protect your information
We adopt appropriate data collection, storage and processing practices and security measures to protect against unauthorized access, alteration, disclosure or destruction of your personal information, username, password, transaction information and data stored on our App.

Sharing your personal information
We do not sell, trade, or rent Users personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners, trusted affiliates and advertisers for the purposes outlined above.

Changes to this privacy policy
Our app has the discretion to update this privacy policy at any time. When we do, we will post a notification on the main page of our App. We encourage Users to frequently check this page for any changes to stay informed about how we are helping to protect the personal information we collect. You acknowledge and agree that it is your responsibility to review this privacy policy periodically and become aware of modifications.

Your acceptance of these terms
By using this App, you signify your acceptance of this policy. If you do not agree to this policy, please do not use our App. Your continued use of the App following the posting of changes to this policy will be deemed your acceptance of those changes.

Contacting us
If you have any questions about this Privacy Policy, the practices of this App, or your dealings with this App, please contact us.
""", style: TextStyle(fontSize: 14)),
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
