import 'package:delverplace/core/responsive.dart';
import 'package:delverplace/src/controller/bottom_bar.dart';
import 'package:delverplace/src/view/screen/all_leads.dart';
import 'package:delverplace/src/view/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../core/constants.dart';
import '../../controller/fonctions.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  inzajController controller = Get.find<inzajController>();
  BottomNavigationBarController navControllers =
      Get.find<BottomNavigationBarController>();
  var test = "";
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool eye1 = true;

  @override
  void initState() {
    super.initState();
    email.text = storage.read('email');
    phone.text = storage.read('phone') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controller.showExitPopup(context);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
        backgroundColor: const Color(0xffEDF5F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEF5F9),
          foregroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              navControllers.updateScreenIndex(2);
              Get.to(() => const AllLeadsScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff011842),
              size: 23,
            ),
          ),
          title: Text(
            'Settings',
            style: GoogleFonts.poppins(
                color: const Color(0xff011842), fontSize: SizeConfig.H * 3),
          ),
          elevation: 1,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AvatarGlow(
                glowColor: const Color(0xff011842),
                endRadius: 90.0,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 700),
                child: Material(
                  elevation: 5.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(194, 254, 254, 1),
                    radius: 80.0,
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      height: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                storage.read('name'),
                style: GoogleFonts.poppins(
                  color: const Color(0xff011842),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(storage.read('email'),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          focusColor: Colors.purple,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontFamily: 'Jannat',
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 5.0),
                          )),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: phone,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          focusColor: Colors.purple,
                          hintText: 'Phone ID',
                          hintStyle: TextStyle(
                            fontFamily: 'Jannat',
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 5.0),
                          )),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: password,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.text,
                      obscureText: eye1,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                eye1 = !eye1;
                              });
                            },
                            icon: eye1 == true
                                ? const Icon(
                                    Icons.remove_red_eye_sharp,
                                    color: Color(0xff011842),
                                  )
                                : const Icon(
                                    Icons.password,
                                    color: Color(0xff011842),
                                  ),
                          ),
                          focusColor: Colors.purple,
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontFamily: 'Jannat',
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff011842), width: 5.0),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(3), // <-- Radius
                              ),
                              height: 40,
                              onPressed: () {
                                controller.showExitPopup2(context);
                                // controller.disconnect(context);
                              },
                              color: Colors.orange,
                              textColor: Colors.white,
                              child: const Text('Deconnexion',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'RobotoMono',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(3), // <-- Radius
                              ),
                              height: 40,
                              onPressed: () {
                                if (email.text.isEmpty) {
                                  test = 'email vide!';
                                } else if (!email.text.contains('@')) {
                                  test = 'missing @';
                                } else if (phone.text.isEmpty) {
                                  test = 'phone vide!';
                                } else if (phone.text.length > 10) {
                                  test = 'Tel:0*********';
                                } else if (password.text.isEmpty) {
                                  test = 'password vide!';
                                } else if (password.text.length < 6) {
                                  test = 'mot de passe court!';
                                }
                                if (test == "") {
                                  controller.profile(email.text, password.text,
                                      phone.text, context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(test)));
                                }
                              },
                              color: const Color(0xff011842),
                              textColor: Colors.white,
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
