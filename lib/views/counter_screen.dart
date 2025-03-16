import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/counter_provider.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CounterProvider>().initCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter app"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(builder: (context, counterProvider, _) {
              return Text("Current count: ${counterProvider.counter}");
            }),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "1",
            onPressed: () {
              context.read<CounterProvider>().decrement();
            },
            child: Icon(Icons.remove),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              context.read<CounterProvider>().increment();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
