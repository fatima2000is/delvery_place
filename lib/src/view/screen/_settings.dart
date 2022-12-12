// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MaterialButton(
          height: 60,
          onPressed: () {},
          color: const Color.fromRGBO(134, 228, 228, 1),
          textColor: Colors.white,
          child: const Text('Deconnexion',
              style: TextStyle(
                color: Colors.purple,
                fontFamily: 'RobotoMono',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      backgroundColor: const Color.fromRGBO(194, 254, 254, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(194, 254, 254, 1),
        leading: const Icon(Icons.arrow_back, color: Colors.purple),
        title: const Text('Settings', style: TextStyle(color: Colors.purple)),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Column(
                  children: [
                    AvatarGlow(
                      glowColor: Colors.purple,
                      endRadius: 90.0,
                      duration: const Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: const Duration(milliseconds: 700),
                      child: Material(
                        elevation: 5.0,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromRGBO(194, 254, 254, 1),
                          radius: 80.0,
                          child: Image.asset(
                            'images/profile1.png',
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Lucas Sanio',
                      style: TextStyle(
                        color: Colors.purple,
                        fontFamily: 'RobotoMono',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('lucassanio@gmail.com',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'RobotoMono',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 90),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 100),
                      child: Container(
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Expanded(
                              child: Text('Profile',
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontFamily: 'RobotoMono',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            const Icon(
                              Icons.arrow_right_alt_outlined,
                              color: Colors.purple,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                                BorderSide(color: Colors.red, width: 5.0),
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
                                BorderSide(color: Colors.red, width: 5.0),
                          )),
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
