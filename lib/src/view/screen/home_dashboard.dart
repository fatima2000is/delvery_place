import 'package:auto_size_text/auto_size_text.dart';
import 'package:delverplace/core/constants.dart';
import 'package:delverplace/src/controller/bottom_bar.dart';
import 'package:delverplace/src/view/screen/settings.dart';
import 'package:delverplace/src/view/widget/bottom_nav.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/responsive.dart';
import '../../controller/fonctions.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchcontroller = TextEditingController();
  BottomNavigationBarController navControllers =
      Get.find<BottomNavigationBarController>();
  String hinttxt = "name,phone";

  var size = SizeConfig();

  inzajController controller = Get.find<inzajController>();

  @override
  void initState() {
    super.initState();
    controller.dashboardData(context);
    controller.getreadyleads();
    controller.insert();
  }

  @override
  Widget build(BuildContext context) {
    size.init(context);
    return WillPopScope(
      onWillPop: () async {
        return controller.showExitPopup(context);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
        floatingActionButton: Obx(
          () => FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Text(
              'There are ${controller.List3.length} leads waitting for you!',
              style: GoogleFonts.poppins(),
            ),
            icon: const Icon(Icons.search),
            backgroundColor: const Color(0xff011842),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEF5F9),
          title: Text(
            "HOME",
            style: GoogleFonts.poppins(
                color: const Color(0xff011842), fontSize: SizeConfig.H * 3),
          ),
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              navControllers.updateScreenIndex(3);
              Get.to(() => const SettingsScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff011842),
              size: 23,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.W * 4,
                right: SizeConfig.W * 4,
              ),
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: SizeConfig.H * 1, bottom: SizeConfig.H * 3),
                  child: build_grade()),
            ),
          ]),
        ),
      ),
    );
  }

  Widget build_grade() => GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //  childAspectRatio: 1,
          mainAxisExtent: SizeConfig.H * 24,
          mainAxisSpacing: SizeConfig.H * 2,
          crossAxisSpacing: SizeConfig.W * 4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) => card(index));

  Widget card(int i) => Container(
        decoration: BoxDecoration(
            color: colors[i], borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: EdgeInsets.only(
              right: SizeConfig.W * 2,
              left: SizeConfig.W * 2,
              top: SizeConfig.W * 2,
              bottom: SizeConfig.W * 2),
          child: SizedBox(
            //color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: SizeConfig.W * 20,
                          child: Text(
                            types[i],
                            style: TextStyle(
                              fontSize: SizeConfig.W * 5,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: SizeConfig.W * 5,
                          child: SvgPicture.asset(assets[i],
                              width: 24.0, height: 24.0, color: colors[i]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: SizeConfig.H * 11,
                    // color: Colors.black,
                    child: Obx(() => AutoSizeText(
                          controller.dataDashboard[i].toString(),

                          maxLines: 3,

                          style: TextStyle(
                            fontSize: SizeConfig.W * 16,
                            fontWeight: FontWeight.bold,
                          ),
                          //  textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
