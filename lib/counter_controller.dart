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

class LoginController extends GetxController {
  RxBool obscureText = true.obs;

  BoolValue() {
    obscureText.value = !obscureText.value;
  }
}

class EmailController extends GetxController {
  var emailError = ''.obs;

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Please enter an email address';
    } else {
      // Use a regular expression for email validation
      String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
      RegExp regex = RegExp(pattern);

      if (!regex.hasMatch(value)) {
        emailError.value = 'Please enter a valid email address';
      } else {
        emailError.value = '';
      }
    }
  }
}

class PasswordController extends GetxController {
  var passwordError = ''.obs;

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Please enter a password';
    } else if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters long';
    } else if (!_hasUppercase(value)) {
      passwordError.value =
          'Password must contain at least one uppercase letter';
    } else if (!_hasLowercase(value)) {
      passwordError.value =
          'Password must contain at least one lowercase letter';
    } else if (!_hasSpecialSymbol(value)) {
      passwordError.value = 'Password must contain at least one special symbol';
    } else {
      passwordError.value = '';
    }
  }

  bool _hasUppercase(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool _hasLowercase(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  bool _hasSpecialSymbol(String value) {
    return value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }
}
