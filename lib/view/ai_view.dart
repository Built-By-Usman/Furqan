import 'package:flutter/material.dart';
import 'package:furqan/controllers/ai_controller.dart';
import 'package:get/get.dart';

import '../widgets/introCardWidget.dart';

class AiView extends StatelessWidget {
  AiView({super.key});

  final AiController controller = Get.put(AiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Islamic AI Scholar',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (controller.messages.isEmpty) {
                  return Center(child: Text('Ask Ai'));
                } else {
                  return const SizedBox.shrink();
                }
              }),
              Expanded(child: MessageListWidget(controller: controller)),
              MessageInputWidget(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
