import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/service/db_service.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Map<String, dynamic>> todoItems = [];
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  final dbService = DbService();

  void deleteNote(int id) {
    dbService.deleteNote(id);
    getNote();
  }

  @override
  void initState() {
    super.initState();
    getNote();
  }

  getNote() async {
    final note = await dbService.getAllNotes();
    todoItems = note;
    print("note :: $note");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter content";
                  }
                  return null;
                },
                decoration: InputDecoration(border: OutlineInputBorder(), label: Text("add content")),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  dbService.addNote(controller.text.trim());
                  controller.clear();
                  getNote();
                }
              },
              child: Text("Add"),
            ),
            const SizedBox(
              height: 10,
            ),
            todoItems.isEmpty
                ? Text("No content")
                : Expanded(
                    child: ListView.builder(
                      itemCount: todoItems.length,
                      itemBuilder: (context, index) {
                        final note = todoItems[index];
                        return ListTile(
                          title: Text(note["note"]),
                          leading: IconButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  dbService.updateNote(note["id"], controller.text.trim());
                                  controller.clear();
                                  getNote();
                                }
                              },
                              icon: Icon(Icons.update)),
                          trailing: IconButton(
                              onPressed: () {
                                ///delete item
                                print(note["id"]);
                                deleteNote(note["id"]);
                              },
                              icon: Icon(Icons.delete)),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
