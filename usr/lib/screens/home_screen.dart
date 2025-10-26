import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _promptController = TextEditingController();
  bool _isLoading = false;
  String? _generatedImageUrl;

  Future<void> _generate() async {
    if (_promptController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a prompt')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _generatedImageUrl = null;
    });

    // --- AI Generation Logic ---
    // This is where you would call your AI image generation service (e.g., a Supabase Edge Function).
    // Since no Supabase project is connected, I will simulate a network delay.
    await Future.delayed(const Duration(seconds: 3));

    // For demonstration, we'll use a placeholder image.
    // In a real app, you would get the URL from your AI service.
    setState(() {
      _generatedImageUrl = 'https://picsum.photos/seed/${_promptController.text.hashCode}/512/512';
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viora'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            onPressed: () {
              // TODO: Implement Prompt Cleaner
            },
            tooltip: 'Clean Prompt',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : _generatedImageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              _generatedImageUrl!,
                              fit: BoxFit.contain,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error, size: 80),
                            ),
                          )
                        : const Text(
                            'Enter a prompt to generate an image',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _promptController,
              decoration: InputDecoration(
                labelText: 'Enter your prompt',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _promptController.clear(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.generating_tokens),
                label: const Text('Generate'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: _isLoading ? null : _generate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
