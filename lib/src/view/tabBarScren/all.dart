import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delverplace/src/controller/fonctions.dart';
import 'package:delverplace/src/model/cardsLeads.dart';

class AllLeads extends StatefulWidget {
  const AllLeads({super.key});

  @override
  State<AllLeads> createState() => _AllLeadsState();
}

class _AllLeadsState extends State<AllLeads> {
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
              itemCount: controller.ListAll.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardsLeads(
                    index: index,
                    lead: controller.ListAll[index],
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
