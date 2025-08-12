// news_page/widgets/reaction_users_list.dart
import 'package:flutter/material.dart';

class ReactionUsersList extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const ReactionUsersList({super.key, required this.users});

  _getReactionIcon(String reaction) {
    switch (reaction) {
      case 'like':
        return Icons.thumb_up;
      case 'love':
        return Icons.favorite;
      case 'haha':
        Text(
          '😂',
          style: TextStyle(fontSize: 24),
        ); // يمكنك استخدام أي أيقونة مناسبة
      case 'wow':
        Text('😮', style: TextStyle(fontSize: 24));
      case 'sad':
        return Text('😢', style: TextStyle(fontSize: 24));
      case 'angry':
        return Text('😡', style: TextStyle(fontSize: 24));
      default:
        return Icons.help;
    }
  }

  Color _getReactionColor(String reaction) {
    switch (reaction) {
      case 'like':
        return Colors.blue;
      case 'love':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'People who reacted',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user['name']!),
                  trailing: Icon(
                    _getReactionIcon(user['reaction']!),
                    color: _getReactionColor(user['reaction']!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
