import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _ephemeralMode = false;

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About Viora'),
          content: const SingleChildScrollView(
            child: Text(
              'Viora – Your ultimate AI-powered image & video generator.\n\nPowered by Audora Tech.\n\nCreate, explore, and generate unlimited visual content seamlessly.\n\nContact / Support: viora.audora@gmail.com',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog({required String title, required String content, required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm', style: TextStyle(color: Colors.red[400])),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title completed.')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('Ephemeral Mode'),
            subtitle: const Text('Generate content without saving anything'),
            value: _ephemeralMode,
            onChanged: (bool value) {
              setState(() {
                _ephemeralMode = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ephemeral Mode ${value ? "enabled" : "disabled"}')),
              );
            },
            secondary: const Icon(Icons.privacy_tip_outlined),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.tune),
            title: const Text('Manage AI Engine Preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to AI settings screen
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.delete_sweep, color: Colors.red[400]),
            title: Text('Clear History', style: TextStyle(color: Colors.red[400])),
            onTap: () {
              _showConfirmationDialog(
                title: 'Clear History',
                content: 'Are you sure you want to delete all your recent prompts and generated content?',
                onConfirm: () {
                  // Add clear history logic here
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red[400]),
            title: Text('Forget All', style: TextStyle(color: Colors.red[400])),
            subtitle: const Text('Deletes all prompts, images, videos, and history immediately.'),
            onTap: () {
               _showConfirmationDialog(
                title: 'Forget All',
                content: 'Are you sure you want to permanently delete all your data? This action cannot be undone.',
                onConfirm: () {
                  // Add forget all logic here
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Viora'),
            onTap: _showAboutDialog,
          ),
        ],
      ),
    );
  }
}
