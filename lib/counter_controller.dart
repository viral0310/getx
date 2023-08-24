import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  RxList textControllers = <TextEditingController>[
    TextEditingController(),
  ].obs;
  RxList text2Controllers = <TextEditingController>[
    TextEditingController(),
  ].obs;
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

class ImagePicker extends GetxController {
  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    final List<XFile>? files = response.files;
    if (files != null) {
      _handleLostFiles(files);
    } else {
      _handleError(response.exception);
    }
  }

  retrieveLostData() {}
}

class _handleError {
  _handleError(PlatformException? exception);
}

class _handleLostFiles {
  _handleLostFiles(List<XFile> files);
}
