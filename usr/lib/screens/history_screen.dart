import 'package:flutter/material.dart';
import 'package:viora/models/generation_item.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Mock data for demonstration purposes
  final List<GenerationItem> _historyItems = const [
    GenerationItem(prompt: 'A futuristic city skyline at sunset, cinematic style', imageUrl: 'https://picsum.photos/seed/picsum/200/300'),
    GenerationItem(prompt: 'A majestic lion with a crown of stars, fantasy art', imageUrl: 'https://picsum.photos/seed/picsum/200/300'),
    GenerationItem(prompt: 'An enchanted forest with glowing mushrooms, watercolor', imageUrl: 'https://picsum.photos/seed/picsum/200/300'),
    GenerationItem(prompt: 'A cute robot waving hello, cartoon style', imageUrl: 'https://picsum.photos/seed/picsum/200/300'),
    GenerationItem(prompt: 'A surreal landscape with floating islands', imageUrl: 'https://picsum.photos/seed/picsum/200/300'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: _historyItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No Generations Yet',
                    style: TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                   Text(
                    'Your past creations will appear here.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _historyItems.length,
              itemBuilder: (context, index) {
                final item = _historyItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        item.imageUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 56),
                      ),
                    ),
                    title: Text(item.prompt),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // Show options like download, share, delete
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
