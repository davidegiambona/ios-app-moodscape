import 'package:flutter/material.dart';
import 'add_note_screen.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';
import '../models/mood.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) toggleDarkMode;
  final bool isDarkMode;

  HomeScreen({required this.toggleDarkMode, required this.isDarkMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Mood> _moodNotes = [];

  void _addNewNote(Mood newNote) {
    setState(() {
      _moodNotes.insert(0, newNote);
    });
  }

  void _navigateToAddNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNoteScreen(onSave: _addNewNote),
      ),
    );
  }

  void _deleteNote(int index) {
    setState(() {
      _moodNotes.removeAt(index);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      // Pagina Home
      Scaffold(
        appBar: AppBar(
          title: Text('Moodscape Journal'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: _navigateToAddNote,
        ),
        body: _moodNotes.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notes, size: 60, color: Colors.grey[300]),
                    SizedBox(height: 20),
                    Text(
                      'Nessuna nota ancora...\nPremi + per iniziare!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: _moodNotes.length,
                itemBuilder: (ctx, index) {
                  final note = _moodNotes[index];
                  return Dismissible(
                    key: Key(note.timestamp.toString()),
                    background: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _deleteNote(index);
                    },
                    child: Card(
                      child: ListTile(
                        leading:
                            Text(note.emoji, style: TextStyle(fontSize: 40)),
                        title: Text(
                          note.description,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              note.journalText,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${note.timestamp.day}/${note.timestamp.month}/${note.timestamp.year}',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      // Pagina Statistiche
      StatsScreen(moodNotes: _moodNotes),
      // Pagina Impostazioni
      SettingsScreen(
        toggleDarkMode: widget.toggleDarkMode,
        isDarkMode: widget.isDarkMode,
      ),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistiche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Impostazioni',
          ),
        ],
      ),
    );
  }
}
