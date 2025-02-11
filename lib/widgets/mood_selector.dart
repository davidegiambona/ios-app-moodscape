import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  final Function(String) onMoodSelected;

  MoodSelector({required this.onMoodSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildMoodButton('😊', 'Felice'),
        _buildMoodButton('😐', 'Neutrale'),
        _buildMoodButton('😔', 'Triste'),
      ],
    );
  }

  Widget _buildMoodButton(String emoji, String mood) {
    return ElevatedButton(
      onPressed: () => onMoodSelected(mood),
      child: Text(emoji, style: TextStyle(fontSize: 30)),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
