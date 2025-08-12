// news_page/widgets/media_widget.dart
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class MediaWidget extends StatefulWidget {
  final String? imageUrl;
  final String? videoUrl;
  final Map<String, String>? matchDetails;
  final Map<String, String>? matchResultDetails;

  const MediaWidget({
    super.key,
    this.imageUrl,
    this.videoUrl,
    this.matchDetails,
    this.matchResultDetails,
  });

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  bool _isPlayerReady = false;
  YoutubePlayerController? _controller;

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

  @override
  Widget build(BuildContext context) {
    if (widget.matchResultDetails != null) {
      return _buildMatchResultWidget();
    }
    if (widget.matchDetails != null) {
      return _buildMatchDetailsWidget();
    }
    if (_controller != null &&
        widget.videoUrl != null &&
        widget.videoUrl!.isNotEmpty) {
      return _buildVideoWidget();
    }
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return _buildImageWidget();
    }
    return const SizedBox.shrink();
  }

  Widget _buildMatchResultWidget() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Text(
            'Match Result',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamColumn(
                widget.matchResultDetails!['team1Image']!,
                widget.matchResultDetails!['team1Name']!,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.matchResultDetails!['score']!,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Full Time',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Colors.blue,
                      ),
                      Text(
                        '15 August 2025',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _buildTeamColumn(
                widget.matchResultDetails!['team2Image']!,
                widget.matchResultDetails!['team2Name']!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchDetailsWidget() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamColumn(
                widget.matchDetails!['team1Image']!,
                widget.matchDetails!['team1Name']!,
              ),
              const Text(
                'VS',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              _buildTeamColumn(
                widget.matchDetails!['team2Image']!,
                widget.matchDetails!['team2Name']!,
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
                      color: Colors.black,
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
                      color: Colors.black,
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

  Widget _buildVideoWidget() {
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl!);
    if (videoId == null) return const SizedBox.shrink();
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

  Widget _buildImageWidget() {
    return Image.network(widget.imageUrl!, fit: BoxFit.cover, height: 200);
  }

  Widget _buildTeamColumn(String image, String name) {
    return Column(
      children: [
        Image.network(image, fit: BoxFit.contain, height: 100, width: 100),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
