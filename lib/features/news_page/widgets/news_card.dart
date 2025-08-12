// news_page/widgets/news_card.dart
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:soccer_app/features/news_page/widgets/media_widget.dart';
import 'package:soccer_app/features/news_page/widgets/reaction_users_list.dart';

class NewsCard extends StatefulWidget {
  final String mainTitle;
  final String title;
  final String date;
  final String? imageUrl;
  final String? videoUrl;
  final Map<String, String>? matchDetails;
  final Map<String, String>? matchResultDetails;

  const NewsCard({
    super.key,
    required this.title,
    required this.date,
    required this.mainTitle,
    this.imageUrl,
    this.videoUrl,
    this.matchDetails,
    this.matchResultDetails,
  });

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final List<Map<String, dynamic>> _reactedUsers = [
    {'name': 'Ahmed', 'reaction': 'like'},
    {'name': 'Sara', 'reaction': 'love'},
    {'name': 'Ali', 'reaction': 'haha'},
    {'name': 'Fatima', 'reaction': 'like'},
    {'name': 'Mohamed', 'reaction': 'wow'},
  ];

  void _showReactionUsers(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ReactionUsersList(users: _reactedUsers);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              widget.mainTitle,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ReadMoreText(
              widget.title,
              trimLines: 2,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.date,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 8.0),
          MediaWidget(
            imageUrl: widget.imageUrl,
            videoUrl: widget.videoUrl,
            matchDetails: widget.matchDetails,
            matchResultDetails: widget.matchResultDetails,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReactionButton<String>(
                    onReactionChanged: (value) {
                      // Handle reaction change
                    },
                    reactions: <Reaction<String>>[
                      Reaction<String>(
                        value: 'like',
                        icon: const Icon(Icons.thumb_up_alt_outlined),
                      ),
                      Reaction<String>(
                        value: 'love',
                        icon: const Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        ),
                      ),
                      Reaction<String>(
                        value: 'haha',
                        icon: const Text('😂', style: TextStyle(fontSize: 24)),
                      ),
                      Reaction<String>(
                        value: 'wow',
                        icon: const Text('😮', style: TextStyle(fontSize: 24)),
                      ),
                      Reaction<String>(
                        value: 'sad',
                        icon: const Text('😢', style: TextStyle(fontSize: 24)),
                      ),
                      Reaction<String>(
                        value: 'angry',
                        icon: const Text('😡', style: TextStyle(fontSize: 24)),
                      ),
                    ],
                    itemSize: const Size(32, 32),
                  ),
                ),
                _buildReactionUsersButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionUsersButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showReactionUsers(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.thumb_up, color: Colors.blue, size: 16),
            const SizedBox(width: 4),
            const Icon(Icons.favorite, color: Colors.red, size: 16),
            const SizedBox(width: 4),
            const Text('😂', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              '${_reactedUsers.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
