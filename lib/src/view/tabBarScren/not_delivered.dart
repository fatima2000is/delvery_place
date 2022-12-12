import 'package:delverplace/src/controller/fonctions.dart';
import 'package:delverplace/src/model/cardsLeads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPoned extends StatefulWidget {
  const PostPoned({super.key});

  @override
  State<PostPoned> createState() => _PostPonedState();
}

class _PostPonedState extends State<PostPoned> {
  inzajController controller = Get.find<inzajController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
              controller.insert();
              controller.getreadyleads();
            },
            child: ListView.builder(
              itemCount: controller.List6.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardsLeads(
                    index: index,
                    lead: controller.List6[index],
                    color: Colors.pink,
                    colorname: const Color(0xFF822685),
                  ),
                );
              },
            ),
          )),
    );
  }
}
