import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NewsPage(),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News page"), centerTitle: true),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          String? imageUrl = index.isEven && index != 1 && index != 2
              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAiUBnIlXP2yBuiLeaf26G3duIP1WjG4NI8A&s'
              : null;

          String? videoUrl = index.isOdd && index != 1 && index != 2
              ? 'https://www.youtube.com/watch?v=mjos3MUxiOQ'
              : null;

          Map<String, String>? matchDetails = index == 1
              ? {
                  'team1Name': 'FC Barcelona',
                  'team1Image':
                      'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/1200px-FC_Barcelona_%28crest%29.svg.png',
                  'team2Name': 'Real Madrid CF',
                  'team2Image':
                      'https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Real_Madrid_CF.svg/1200px-Real_Madrid_CF.svg.png',
                }
              : null;

          Map<String, String>? matchResultDetails = index == 2
              ? {
                  'team1Name': 'FC Barcelona',
                  'team1Image':
                      'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/1200px-FC_Barcelona_%28crest%29.svg.png',
                  'team2Name': 'Real Madrid CF',
                  'team2Image':
                      'https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Real_Madrid_CF.svg/1200px-Real_Madrid_CF.svg.png',
                  'score': '3 - 2',
                }
              : null;

          return NewsCard(
            mainTitle: "The champion",
            title: 'News Title ${index + 1}',
            date: '9 august 2025',
            imageUrl: imageUrl,
            videoUrl: videoUrl,
            matchDetails: matchDetails,
            matchResultDetails: matchResultDetails,
          );
        },
      ),
    );
  }
}

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
  bool _isPlayerReady = false;
  YoutubePlayerController? _controller;

  final List<Map<String, dynamic>> _reactedUsers = [
    {'name': 'Ahmed', 'reaction': 'like'},
    {'name': 'Sara', 'reaction': 'love'},
    {'name': 'Ali', 'reaction': 'haha'},
    {'name': 'Fatima', 'reaction': 'like'},
    {'name': 'Mohamed', 'reaction': 'wow'},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl!);
      if (videoId != null) {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        );
        _controller!.addListener(_fullScreenListener);
      }
    }
  }

  void _fullScreenListener() {
    if (_controller == null) return;
    if (_controller!.value.isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_fullScreenListener);
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  void _showReactionUsers(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _ReactionUsersList(users: _reactedUsers);
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
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 8.0),
          _buildMediaWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReactionButton<String>(
                    onReactionChanged: (value) {
                      print(value);
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

  Widget _buildMediaWidget() {
    if (widget.matchResultDetails != null) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text(
              'Match Result',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.network(
                      widget.matchResultDetails!['team1Image']!,
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.matchResultDetails!['team1Name']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Text(
                  widget.matchResultDetails!['score']!,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                Column(
                  children: [
                    Image.network(
                      widget.matchResultDetails!['team2Image']!,
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.matchResultDetails!['team2Name']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  '15 August 2025',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 9),

            const Text(
              'Full Time',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      );
    }

    if (widget.matchDetails != null) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // تم تعديل هذا السطر
              children: [
                Column(
                  children: [
                    Image.network(
                      widget.matchDetails!['team1Image']!,
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.matchDetails!['team1Name']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 148, 41, 33),
                  ),
                ),
                Column(
                  children: [
                    Image.network(
                      widget.matchDetails!['team2Image']!,
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.matchDetails!['team2Name']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '15 August 2025',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.stadium, size: 20, color: Colors.blue),
                    const SizedBox(width: 5),
                    Text(
                      'Camp Nou',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    if (_controller != null &&
        widget.videoUrl != null &&
        widget.videoUrl!.isNotEmpty) {
      String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl!);
      if (videoId != null) {
        return _isPlayerReady
            ? YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
                onReady: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      YoutubePlayer.getThumbnail(
                        videoId: videoId,
                        quality: ThumbnailQuality.medium,
                      ),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    const Icon(
                      Icons.play_circle_fill,
                      size: 60,
                      color: Colors.white,
                    ),
                  ],
                ),
              );
      }
    }
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return Image.network(widget.imageUrl!, fit: BoxFit.cover, height: 200);
    }
    return const SizedBox.shrink();
  }
}

class _ReactionUsersList extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const _ReactionUsersList({Key? key, required this.users}) : super(key: key);

  _getReactionIcon(String reaction) {
    switch (reaction) {
      case 'like':
        return const Icon(Icons.thumb_up, color: Colors.blue, size: 20);
      case 'love':
        return const Icon(Icons.favorite, color: Colors.red, size: 20);
      case 'haha':
        return const Text('😂', style: TextStyle(fontSize: 24));
      case 'wow':
        return const Text('😮', style: TextStyle(fontSize: 24));
      case 'sad':
        return const Text('😢', style: TextStyle(fontSize: 24));
      case 'angry':
        return const Text('😡', style: TextStyle(fontSize: 24));
      default:
        return const Icon(Icons.help, size: 20);
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
                  trailing: _getReactionIcon(user['reaction']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
