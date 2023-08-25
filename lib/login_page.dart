import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/counter_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());
  final EmailController emailController = Get.put(EmailController());
  final PasswordController passwordController = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          'Login using GetX',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(
          Icons.get_app,
          color: Colors.white,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: (value) {
                    Get.find<EmailController>().validateEmail(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    Get.find<PasswordController>().validatePassword(value);
                  },
                  obscureText: controller.obscureText.value,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: InkWell(
                      onTap: controller.BoolValue,
                      child: const Icon(
                        CupertinoIcons.eye_slash,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GetX<EmailController>(
                  init: EmailController(),
                  builder: (controller) {
                    return Text(
                      controller.emailError.value,
                      style: const TextStyle(color: Colors.red),
                    );
                  },
                ),
                const SizedBox(height: 10),
                GetX<PasswordController>(
                  init: PasswordController(),
                  builder: (controller) {
                    return Text(
                      controller.passwordError.value,
                      style: const TextStyle(color: Colors.red),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print('Email is valid: ${emailController.emailError}');
                    print(
                        'Password is valid: ${passwordController.passwordError}');
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          )),
    );
  }
}
