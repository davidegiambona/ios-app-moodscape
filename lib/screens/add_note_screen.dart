import 'package:flutter/material.dart';
import '../models/mood.dart';

class AddNoteScreen extends StatefulWidget {
  final Function(Mood) onSave;

  AddNoteScreen({required this.onSave});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _textController = TextEditingController();
  String _selectedMood = 'Neutrale';
  String _selectedEmoji = '😐';

  final Map<String, String> _moodOptions = {
    'Felice': '😊',
    'Neutrale': '😐',
    'Triste': '😔',
  };

  void _submit() {
    if (_textController.text.isEmpty) return;

    final newNote = Mood(
      emoji: _selectedEmoji,
      description: _selectedMood,
      journalText: _textController.text,
      timestamp: DateTime.now(),
    );

    widget.onSave(newNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuova Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Come ti senti oggi?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: _moodOptions.entries.map((entry) {
                return ChoiceChip(
                  label: Text('${entry.value} ${entry.key}'),
                  selected: _selectedMood == entry.key,
                  onSelected: (selected) {
                    setState(() {
                      _selectedMood = entry.key;
                      _selectedEmoji = entry.value;
                    });
                  },
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Theme.of(context).cardColor,
                  labelStyle: TextStyle(
                    color: _selectedMood == entry.key
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Descrivi la tua giornata',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                labelStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text(
                'Salva',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
