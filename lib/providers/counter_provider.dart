import 'package:flutter/foundation.dart';
import 'package:flutter_first_app/service/db_service.dart';

class CounterProvider extends ChangeNotifier {
  int counter = 0;

  final dbService = DbService();

  void increment() {
    counter++;
    notifyListeners();
    saveCounter();
  }

  initCounter() async {
    final initialCounter = await dbService.getCounterValue();
    print("initial counter : $initialCounter");
    counter = initialCounter;
    notifyListeners();
  }

  void decrement() {
    if (counter > 0) {
      counter--;
    }
    notifyListeners();
    saveCounter();
  }

  void saveCounter() {
    dbService.saveCounterValue(counter);
  }
}
