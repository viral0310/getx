import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/counter_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ModifierController modifierController = Get.put(ModifierController());
  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => ReorderableListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  modifierController.items.insert(
                      newIndex, modifierController.items.removeAt(oldIndex));
                  modifierController.textControllers.insert(newIndex,
                      modifierController.textControllers.removeAt(oldIndex));
                  modifierController.text2Controllers.insert(newIndex,
                      modifierController.text2Controllers.removeAt(oldIndex));
                },
                children: List.generate(
                  modifierController.textFieldCount.value,
                  (index) => ListTile(
                    key: Key('$index'),
                    title: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.white,
                      ),
                      width: width,
                      height: height / 14,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller:
                                    modifierController.textControllers[index],
                                decoration: const InputDecoration(
                                  hintText: 'Name',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller:
                                    modifierController.text2Controllers[index],
                                decoration: const InputDecoration(
                                  hintText: 'INR0.00',
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  modifierController.removeItem(index),
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Image.asset(
                                  'assets/images/close.png',
                                  color: Colors.red,
                                  width: 17,
                                  height: 17,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Icon(
                                CupertinoIcons.arrow_up_down_circle,
                                color: Color(0xff5654a2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                modifierController.textFieldCount.value++;
                modifierController.textControllers.add(
                  TextEditingController(),
                );
                modifierController.text2FieldCount.value++;
                modifierController.text2Controllers.add(
                  TextEditingController(),
                );
                modifierController.items.add('');
              },
              icon: const Icon(
                CupertinoIcons.plus_circle_fill,
                color: Color(0xff5654a2),
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
