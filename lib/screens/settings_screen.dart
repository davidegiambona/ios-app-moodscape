import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(bool) toggleDarkMode;
  final bool isDarkMode;

  SettingsScreen({required this.toggleDarkMode, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Impostazioni'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Modalità Scura'),
              value: isDarkMode,
              onChanged: toggleDarkMode,
            ),
          ],
        ),
      ),
    );
  }
}
