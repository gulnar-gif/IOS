
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note_item.dart';

const green = Color(0xFF256B4A);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('app_theme_dark_mode') ?? false;
  final username = prefs.getString('user_display_name') ?? 'Guest User';
  final savedNotes = prefs.getString('saved_notes') ?? '[]';

  List<NoteItem> notes = [];
  try {
    final data = jsonDecode(savedNotes) as List;
    notes = data
        .map((e) => NoteItem.fromJson(e as Map<String, dynamic>))
        .toList();
  } catch (e) {
    notes = [];
  }

  runApp(MemoFlowApp(
    prefs: prefs,
    initialDark: isDark,
    username: username,
    notes: notes,
  ));
}

class MemoFlowApp extends StatefulWidget {
  final SharedPreferences prefs;
  final bool initialDark;
  final String username;
  final List<NoteItem> notes;

  const MemoFlowApp({
    super.key,
    required this.prefs,
    required this.initialDark,
    required this.username,
    required this.notes,
  });

  @override
  State<MemoFlowApp> createState() => _MemoFlowAppState();
}

class _MemoFlowAppState extends State<MemoFlowApp> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = widget.initialDark;
  }

  Future<void> changeTheme(bool value) async {
    setState(() => isDark = value);
    await widget.prefs.setBool('app_theme_dark_mode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemoFlow',
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        scaffoldBackgroundColor: const Color(0xFFF4F9F5),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          brightness: Brightness.dark,
        ),
      ),
      home: NotesScreen(
        prefs: widget.prefs,
        initialName: widget.username,
        initialNotes: widget.notes,
        isDark: isDark,
        onThemeChanged: changeTheme,
      ),
    );
  }
}

class NotesScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final String initialName;
  final List<NoteItem> initialNotes;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const NotesScreen({
    super.key,
    required this.prefs,
    required this.initialName,
    required this.initialNotes,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late String username;
  late List<NoteItem> notes;

  final nameController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    username = widget.initialName;
    notes = List.from(widget.initialNotes);
    nameController.text = username;
  }

  Future<void> saveName() async {
    final name = nameController.text.trim();
    final newName = name.isEmpty ? 'Guest User' : name;

    await widget.prefs.setString('user_display_name', newName);

    if (!mounted) return;
    setState(() => username = newName);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Name saved!')),
    );
  }

  Future<void> saveNotes() async {
    final data = jsonEncode(
      notes.map((note) => note.toJson()).toList(),
    );
    await widget.prefs.setString('saved_notes', data);
  }

  Future<void> addNote() async {
    final title = noteController.text.trim();
    if (title.isEmpty) return;

    final now = DateTime.now();

    setState(() {
      notes.insert(
        0,
        NoteItem(
          id: now.microsecondsSinceEpoch.toString(),
          title: title,
          dateText: now.toString().substring(0, 16),
        ),
      );
      noteController.clear();
    });

    await saveNotes();
  }

  Future<void> toggleNote(String id, bool value) async {
    setState(() {
      notes.firstWhere((note) => note.id == id).isCompleted = value;
    });
    await saveNotes();
  }

  Future<void> deleteNote(String id) async {
    setState(() {
      notes.removeWhere((note) => note.id == id);
    });
    await saveNotes();
  }

  @override
  void dispose() {
    nameController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final completed = notes.where((note) => note.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MemoFlow',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            widget.isDark ? Icons.dark_mode : Icons.light_mode,
          ),
          Switch(
            value: widget.isDark,
            onChanged: widget.onThemeChanged,
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Hello, $username!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Organize your day, one note at a time.',
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Your name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: saveName,
                          child: const Text('Save Name'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),
              const Text(
                'My Notes',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$completed of ${notes.length} completed',
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 14),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: noteController,
                          decoration: const InputDecoration(
                            hintText: 'Write a new note...',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => addNote(),
                        ),
                      ),
                      IconButton.filled(
                        onPressed: addNote,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (notes.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    children: [
                      Icon(
                        Icons.note_alt_outlined,
                        size: 65,
                        color: colors.primary,
                      ),
                      const SizedBox(height: 12),
                      const Text('No notes yet. Add your first note!'),
                    ],
                  ),
                ),

              ...notes.map(
                (note) => Card(
                  key: ValueKey(note.id),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Checkbox(
                      value: note.isCompleted,
                      onChanged: (value) {
                        toggleNote(note.id, value ?? false);
                      },
                    ),
                    title: Text(
                      note.title,
                      style: TextStyle(
                        decoration: note.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(note.dateText),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => deleteNote(note.id),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),
              Center(
                child: Text(
                  'Saved locally • Works offline',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
