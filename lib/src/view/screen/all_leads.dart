import 'package:delverplace/core/responsive.dart';
import 'package:delverplace/src/controller/bottom_bar.dart';
import 'package:delverplace/src/view/screen/find_leads.dart';
import 'package:delverplace/src/view/tabBarScren/all.dart';
import 'package:delverplace/src/view/tabBarScren/ready.dart';
import 'package:delverplace/src/view/widget/bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delverplace/src/controller/fonctions.dart';
import 'package:delverplace/src/model/tabbartbottom.dart';
import 'package:delverplace/src/view/tabBarScren/canled.dart';
import 'package:delverplace/src/view/tabBarScren/delvred.dart';
import 'package:delverplace/src/view/tabBarScren/not_delivered.dart';
import 'package:delverplace/src/view/tabBarScren/returned.dart';
import 'package:delverplace/src/view/tabBarScren/shiped.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllLeadsScreen extends StatefulWidget {
  const AllLeadsScreen({super.key});

  @override
  State<AllLeadsScreen> createState() => _AllLeadsScreenState();
}

class _AllLeadsScreenState extends State<AllLeadsScreen>
    with SingleTickerProviderStateMixin {
  inzajController controllers = Get.find<inzajController>();
  BottomNavigationBarController navControllers =
      Get.find<BottomNavigationBarController>();

  TabController? _controller;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controller = TabController(length: 7, vsync: this, initialIndex: 0);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    controllers.getreadyleads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controllers.showExitPopup(context);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: AppBar(
            backgroundColor: const Color(0xFFEEF5F9),
            title: Text(
              "Orders",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  color: const Color(0xff011842), fontSize: SizeConfig.H * 3),
            ),
            centerTitle: true,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                navControllers.updateScreenIndex(1);
                Get.to(() => const FindLeadsScreen());
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xff011842),
                size: 23,
              ),
            ),
            bottom: TabBar(
              // padding: const EdgeInsets.all(2),
              // labelColor: const Color(0xFF822685),
              // unselectedLabelColor: Colors.black,
              // controller: _controller,
              // indicatorWeight: 1,
              // indicatorColor: const Color(0xFF822685),
              // indicatorSize: TabBarIndicatorSize.label,
              // labelPadding: const EdgeInsets.all(2),
              labelColor: const Color(0xff011842),
              controller: _controller,
              indicatorWeight: 1,
              indicatorColor: const Color(0xff011842),
              //unselectedLabelColor: theme.secondary,
              indicatorSize: TabBarIndicatorSize.tab,
              //indicatorColor: const Color(0xff011842),
              labelStyle: GoogleFonts.poppins().copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              labelPadding: const EdgeInsets.only(right: 20, bottom: 10),
              padding: const EdgeInsets.only(left: 10),
              isScrollable: true,
              tabs: const [
                TabBarBotton(
                  label: 'All',
                  // assetsicons: 'assets/images/delivred.png',
                  color: Colors.black,
                ),
                TabBarBotton(
                  label: 'Ready',
                  // assetsicons: 'assets/images/delivred.png',
                  color: Colors.black,
                ),
                TabBarBotton(
                  label: 'Shipped',
                  // assetsicons: 'assets/images/delivred.png',
                  color: Colors.black,
                ),
                TabBarBotton(
                  label: 'Canceled',
                  // assetsicons: 'assets/images/shiped.png',
                  color: Colors.black,
                ),
                TabBarBotton(
                  label: 'Returned',
                  // assetsicons: 'assets/images/returned.png',
                  color: Colors.black,
                ),
                TabBarBotton(
                  label: 'Not Delivered',
                  // assetsicons: 'assets/images/postponed.png',
                  color: Colors.black,
                ),
                TabBarBotton(
                  label: 'Delivered',
                  // assetsicons: 'assets/images/returned.png',
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _controller,
            children: const [
              AllLeads(),
              Ready(),
              Shiped(),
              Canled(),
              Returned(),
              PostPoned(),
              Delvred(),
            ],
          ),
        ),
      ),
    );
  }
}
