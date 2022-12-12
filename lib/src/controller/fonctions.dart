// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:delverplace/core/constants.dart';
import 'package:delverplace/src/controller/connectionmanager.dart';
import 'package:delverplace/src/model/lead.dart';
import 'package:delverplace/src/view/screen/home_dashboard.dart';
import 'package:delverplace/src/view/screen/login.dart';
import 'package:delverplace/src/view/widget/state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class inzajController extends GetxController {
  NetworkController networkController = Get.find<NetworkController>();

  RxList<Lead> List1 = <Lead>[].obs;
  RxList<Lead> List2 = <Lead>[].obs;
  RxList<Lead> List3 = <Lead>[].obs;
  RxList<Lead> List4 = <Lead>[].obs;
  RxList<Lead> List5 = <Lead>[].obs;
  RxList<Lead> List6 = <Lead>[].obs;
  RxList<Lead> ListAll = <Lead>[].obs;
  RxList<Lead> List8 = <Lead>[].obs;
  RxList dataDashboard = [0, 0, 0, 0, 0, 0].obs;
  bool isTokenValid = true;

  insert() async {
    var token = storage.read('token');

    final response = await http.get(
      Uri.parse('https://mobile.palace-agency.com/api/leads'),
      // Send authorization headers to the backend.
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        // 'state': 'ready to ship'
        // 'state': 'shipped'
        // 'state': 'shipped'
        'state': 'all'
      },
    );

    var res = jsonDecode(response.body);

    var value = res['data'];

    List1.clear();
    List2.clear();

    List4.clear();
    List5.clear();
    List6.clear();
    ListAll.clear();

    for (int i = 0; i < res['data'].length; i++) {
      ListAll.add(Lead.fromJson(value[i]));
      if (res['data'][i]['status_livrison'] == 'delivered') {
        List1.add(Lead.fromJson(value[i]));
      } else if (res['data'][i]['status_livrison'] == 'shipped') {
        List2.add(Lead.fromJson(value[i]));
        /* } else if (res['data'][i]['status_livrison'] == 'ready to ship') {
        List3.add(Lead.fromJson(value[i]));*/
      } else if (res['data'][i]['status_livrison'] == 'returned') {
        List4.add(Lead.fromJson(value[i]));
      } else if (res['data'][i]['status_livrison'] == 'canceled') {
        List5.add(Lead.fromJson(value[i]));
      } else if (res['data'][i]['status_livrison'] == 'not delivered') {
        List6.add(Lead.fromJson(value[i]));
      }
    }
  }

  getreadyleads() async {
    var token = storage.read('token');
    List3.clear();
    try {
      final response = await http.get(
        Uri.parse('https://mobile.palace-agency.com/api/leads'),
        // Send authorization headers to the backend.
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          // 'state': 'ready to ship'
          // 'state': 'shipped'
          // 'state': 'shipped'
          'state': 'ready to ship'
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (int i = 0; i < data['data'].length; i++) {
          List3.add(Lead.fromJson(data['data'][i]));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  changeStatus(ref, status, context, str) async {
    var token = storage.read('token');

    await http
        .post(Uri.parse('https://mobile.palace-agency.com/api/lead'), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'reference': ref.toString(),
      'state': status,
      'text': str
    });

    Navigator.pop(context);
  }

  profile(email, password, phone, context) async {
    var token = storage.read('token');

    await http.post(Uri.parse('https://mobile.palace-agency.com/api/updatuser'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'phone': phone,
          'email': email,
          'password': password
        });

    storage.write('email', email);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  disconnect(context) async {
    storage.remove('token');
    storage.remove('id_user');
    storage.remove('email');
    storage.remove('name');
    await Future.delayed(const Duration(seconds: 5));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  void auth(context, email, password) async {
    var url = Uri.https('mobile.palace-agency.com', '/api/user');
    var response =
        await http.post(url, body: {'email': email, 'password': password});

    var res = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      storage.write('id_user', res['user']['id']);
      storage.write('token', res['token']);
      storage.write('email', res['user']['email']);
      storage.write('name', res['user']['name']);
      storage.write('phone', res['user']['phone']);

      dashboardData(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
      final snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Text(
          "Connected successfully",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Text(
          "invalid account",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        elevation: 1,
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void checkToken(BuildContext context) async {
    var token = storage.read('token');
    var id = storage.read('id_user');

    if (token == null) {
      isTokenValid = false;
      update();
    }

    if (networkController.connectionType == 0) {
      await Future.delayed(
        const Duration(seconds: 3),
      );
      isTokenValid = false;
      update();
    }

    await Future.delayed(
      const Duration(seconds: 3),
    );

    var url = Uri.https('mobile.palace-agency.com', '/api/isconnected');
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'token': token,
      'id_user': id.toString(),
    }).timeout(
      const Duration(seconds: 3),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.to(() => const DashboardScreen());
    } else {
      isTokenValid = false;
      update();
    }
  }

  void dashboardData(
    context,
  ) async {
    var token = storage.read('token');
    final response = await http.get(
      Uri.parse('https://mobile.palace-agency.com/api/dashboard'),
      // Send authorization headers to the backend.
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var res = jsonDecode(response.body);
    print(res);
    dataDashboard.clear();
    if (response.statusCode == 201 || response.statusCode == 200) {
      for (int i = 0; i < res.length; i++) {
        dataDashboard.add(res[i]['total']);
      }
    }
  }

  scanner(ref, context) {
    {
      var t = 1;
      for (int i = 0; i < ListAll.length; i++) {
        if (ListAll[i].tracking == ref.toString()) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StatusView(
                      tracking: ListAll[i].tracking,
                      city: ListAll[i].city,
                      products: ListAll[i].products,
                      name: ListAll[i].name,
                      address: ListAll[i].address,
                      phone: ListAll[i].phone,
                      phone2: ListAll[i].phone2,
                      prix: ListAll[i].price.toString(),
                      status_livrison: ListAll[i].statusLivrison,
                    )),
          );
          t = 0;
          //
        }
      }
      //
      if (t == 1) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('leads not founded'),
            content: Text('can\'t find leds with reference ${ref}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                },
                child: const Text('ok'),
              ),
            ],
          ),
        );
      }
    }
  }

  scanner2(ref, context) async {
    {
      var t = 1;
      for (int i = 0; i < List3.length; i++) {
        if (List3[i].tracking == ref.toString()) {
          _displayTextScanAssign(context, ref);
          t = 0;
          //
        }
      }

      if (t == 1) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('leads not founded'),
            content: Text('can\'t find leds with reference $ref'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                },
                child: const Text('ok'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _displayTextScanAssign(BuildContext context, String ref) async {
    TextEditingController textFieldController = TextEditingController();
    var text = RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          const TextSpan(text: "The lead with tracking num: "),
          TextSpan(
              text: ' ${ref} ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(
            text: "is now assinged to you!",
          ),
        ],
      ),
    );
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: text,
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Spacer(),
                  MaterialButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: const Text('OK'),
                    onPressed: () {
                      // codeDialog = valueText;
                      changeStatus(ref, 'shipped', context, '');
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future<void> _displayTextInputDialog(BuildContext context, String ref) async {
    TextEditingController _textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Raison'),
            content: TextField(
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "...."),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.orange,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  // codeDialog = valueText;
                  changeStatus(
                      ref, 'shipped', context, _textFieldController.text);
                  // Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Image.asset(
              'assets/images/warning.png',
              height: 60,
            ),
            content: Text(
              'Do you want to exit an App?',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xff011842),
                      ),
                      height: 35,
                      width: 85,
                      child: Center(
                        child: Text(
                          'No',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      storage.remove('token');
                      storage.remove('id_user');
                      storage.remove('email');
                      storage.remove('name');

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const Login()),
                          (Route<dynamic> route) => false);
                    },
                    //return false when click on "NO"
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff011842)),
                      height: 35,
                      width: 85,
                      child: Center(
                        child: Text(
                          'yes',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  showExitPopup2(context) async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Image.asset(
          'assets/images/warning.png',
          height: 60,
        ),
        content: Text(
          'Do you want to exit an App?',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child: Container(
              height: 45,
              width: 40,
              child: Text(
                'No',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              storage.remove('token');
              storage.remove('id_user');
              storage.remove('email');
              storage.remove('name');

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Login()),
                  (Route<dynamic> route) => false);
            },
            //return false when click on "NO"
            child: Container(
              color: Colors.red,
              height: 45,
              width: 40,
              child: Text(
                'yes',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    ); //if showDialouge had returned null, then return false
  }
}
