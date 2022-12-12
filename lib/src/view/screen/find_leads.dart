import 'package:delverplace/core/responsive.dart';
import 'package:delverplace/src/controller/SearchController.dart';
import 'package:delverplace/src/controller/bottom_bar.dart';
import 'package:delverplace/src/controller/fonctions.dart';
import 'package:delverplace/src/model/cardsLeads.dart';
import 'package:delverplace/src/view/screen/home_dashboard.dart';
import 'package:delverplace/src/view/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/scanner_widget.dart';
import '../widget/scanner_widget2.dart';

class FindLeadsScreen extends StatefulWidget {
  const FindLeadsScreen({super.key});

  @override
  State<FindLeadsScreen> createState() => _FindLeadsScreenState();
}

class _FindLeadsScreenState extends State<FindLeadsScreen> {
  final TextEditingController _searchcontroller = TextEditingController();
  SerachController controller = Get.find<SerachController>();
  inzajController controllers = Get.find<inzajController>();
  BottomNavigationBarController navControllers =
      Get.find<BottomNavigationBarController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controllers.showExitPopup(context);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 25,
              left: 25,
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  //Get.back();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScannerCode()),
                  );
                },
                label: Text(
                  'All',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                icon: const Icon(Icons.search),
                backgroundColor: const Color.fromARGB(255, 70, 88, 121),
              ),
            ),
            Positioned(
              bottom: 25,
              right: 0,
              child: FloatingActionButton.extended(
                heroTag: "btn2",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScannerCode2()),
                  );
                },
                label: Text(
                  'Ready',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                icon: const Icon(Icons.search),
                backgroundColor: const Color.fromARGB(255, 204, 138, 51),
              ),
            )
          ],
        ),
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: const Color(0xFFEEF5F9),
          title: Text(
            "Search",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
                color: const Color(0xff011842), fontSize: SizeConfig.H * 3),
          ),
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              navControllers.updateScreenIndex(0);
              Get.to(() => const DashboardScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff011842),
              size: 23,
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xffEDF5F8),
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  onFieldSubmitted: ((value) {}),
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    border:
                        const UnderlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: InkWell(
                      onTap: () async {
                        controller.filterSearchResults(_searchcontroller.text);
                        await Future.delayed(const Duration(seconds: 2), () {
                          if (controller.isFound == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.orange),
                                  child: Text(
                                    "The lead you search for is not found!",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff011842),
                                        fontSize: SizeConfig.H * 2.2),
                                  ),
                                ),
                              ),
                            );
                          }
                        });
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,

                        // color: const Color.fromARGB(255, 204, 138, 51),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 204, 138, 51),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4)),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 14),
                    hintText: "Search",
                    hintStyle: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.4)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.leadlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CardsLeads(
                          index: index,
                          color: Colors.pink,
                          lead: controller.leadlist[index],
                          colorname: const Color(0xFF822685),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
