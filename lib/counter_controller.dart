import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CounterController extends GetxController {
  RxInt counter = 0.obs;

  incrementCounter() {
    counter.value++;
  }

  decrementCounter() {
    counter.value--;
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

class ImagePickerController extends GetxController {
  RxString imagePath = ''.obs;

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath.value = pickedImage.path.toString();
    }
  }
}
