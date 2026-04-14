import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/nexaryo_colors.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  static const _storageKey = 'nexaryo_sg_notes';
  List<_Note> _notes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      final list = jsonDecode(raw) as List;
      _notes = list
          .map((e) => _Note.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    setState(() => _loading = false);
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(_notes.map((n) => n.toJson()).toList()),
    );
  }

  void _addNote() async {
    final result = await _showEditor(context);
    if (result != null && result.trim().isNotEmpty) {
      setState(() {
        _notes.insert(0, _Note(text: result.trim(), createdAt: DateTime.now()));
      });
      _saveNotes();
    }
  }

  void _editNote(int index) async {
    final result = await _showEditor(context, initial: _notes[index].text);
    if (result != null) {
      if (result.trim().isEmpty) {
        setState(() => _notes.removeAt(index));
      } else {
        setState(
          () => _notes[index] = _Note(
            text: result.trim(),
            createdAt: _notes[index].createdAt,
          ),
        );
      }
      _saveNotes();
    }
  }

  void _deleteNote(int index) {
    setState(() => _notes.removeAt(index));
    _saveNotes();
  }

  Future<String?> _showEditor(BuildContext context, {String? initial}) {
    final controller = TextEditingController(text: initial);
    final c = context.colors;
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: c.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: c.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                maxLines: 6,
                minLines: 3,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: c.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Write your note...',
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: c.textDim,
                  ),
                  filled: true,
                  fillColor: c.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: c.cardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: c.cardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: c.primary),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, controller.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: c.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Text(
                    initial == null ? 'Add Note' : 'Save',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        backgroundColor: c.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedAdd01,
          color: Colors.white,
          size: 28,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: IconButton(
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowLeft01,
                        color: c.textDim,
                        size: 24,
                      ),
                      iconSize: 24,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Notes',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _notes.isEmpty
                  ? Center(
                      child: Text(
                        'No notes yet',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: c.textDim,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _notes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) => _buildNoteCard(context, i),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, int index) {
    final c = context.colors;
    final note = _notes[index];
    final date =
        '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}';

    return Dismissible(
      key: ValueKey(note.createdAt.toIso8601String() + note.text),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _deleteNote(index),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.15),
          borderRadius: BorderRadius.circular(34),
        ),
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedDelete01,
          color: Colors.red,
          size: 24,
        ),
      ),
      child: GestureDetector(
        onTap: () => _editNote(index),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: c.card,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: c.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.text,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: c.textPrimary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                date,
                style: GoogleFonts.montserrat(fontSize: 12, color: c.textDim),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Note {
  final String text;
  final DateTime createdAt;

  _Note({required this.text, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'text': text,
    'createdAt': createdAt.toIso8601String(),
  };

  factory _Note.fromJson(Map<String, dynamic> json) => _Note(
    text: json['text'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}
