import 'package:delverplace/src/controller/fonctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delverplace/src/model/cardsLeads.dart';

class Canled extends StatefulWidget {
  const Canled({super.key});

  @override
  State<Canled> createState() => _CanledState();
}

class _CanledState extends State<Canled> {
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
              itemCount: controller.List5.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardsLeads(
                    index: index,
                    lead: controller.List5[index],
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
