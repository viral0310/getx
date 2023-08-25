import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/counter_controller.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          'GetX Tutorial',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => Center(
          child: InkWell(
            onTap: () {
              imagePickerController.pickImage();
            },
            child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: imagePickerController.imagePath.isNotEmpty
                    ? FileImage(
                        File(
                          imagePickerController.imagePath.toString(),
                        ),
                      )
                    : null),
          ),
        ),
      ),
    );
  }
}
