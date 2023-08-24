import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt Counter = 0.obs;

  incrementCounter() {
    Counter.value++;
  }

  decrementCounter() {
    Counter.value--;
  }
}

class ModifierController extends GetxController {
  var modifierEditingController = TextEditingController();
  var textControllers = <TextEditingController>[].obs;
  var text2Controllers = <TextEditingController>[].obs;
  RxInt textFieldCount = 1.obs;
  RxInt text2FieldCount = 1.obs;

  var items = List<String>.generate(50, (index) => '').obs;

  void removeItem(int index) {
    text2Controllers[index].dispose();
    text2Controllers.removeAt(index);
    textControllers[index].dispose();
    textControllers.removeAt(index);
    items.removeAt(index);
    textFieldCount.value -= 1;
  }

  void addNewField() {
    textFieldCount.value++;
    textControllers.add(TextEditingController());
    text2FieldCount.value++;
    text2Controllers.add(TextEditingController());
    items.add('');
  }

  @override
  void onClose() {
    modifierEditingController.dispose();
    for (var controller in textControllers) {
      controller.dispose();
    }
    for (var controller in text2Controllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
