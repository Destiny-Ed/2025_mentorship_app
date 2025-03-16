import 'package:flutter/material.dart';

class ScrollableScreen extends StatefulWidget {
  const ScrollableScreen({super.key});

  @override
  State<ScrollableScreen> createState() => _ScrollableScreenState();
}

class _ScrollableScreenState extends State<ScrollableScreen> {
  List<String> todoItems = [];
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  void deleteTodo(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scrollable"),
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
                    return "please enter todo";
                  }
                  return null;
                },
                decoration: InputDecoration(border: OutlineInputBorder(), label: Text("add todo")),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  todoItems.add(controller.text);
                  controller.clear();
                  setState(() {});
                }
              },
              child: Text("Add todo"),
            ),
            const SizedBox(
              height: 10,
            ),
            todoItems.isEmpty
                ? Text("No todo")
                : Expanded(
                    child: ListView.builder(
                      itemCount: todoItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(todoItems[index]),
                          trailing: IconButton(
                              onPressed: () {
                                ///delete item
                                deleteTodo(index);
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
