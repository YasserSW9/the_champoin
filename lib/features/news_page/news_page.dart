// news_page/news_page.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soccer_app/features/news_page/widgets/news_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _pickImageFromGallery() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        print('Image path: ${image.path}');
      }
    }

    void _showYoutubeUrlDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter the video URL'),
            content: const TextField(
              decoration: InputDecoration(
                labelText: 'YouTube URL',
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Enter the news title'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'News Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _pickImageFromGallery();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add Image from Gallery'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showYoutubeUrlDialog(context);
                        },
                        child: const Text('Add YouTube Link'),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
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
