import 'dart:convert';
import 'package:delverplace/src/model/lead.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:delverplace/core/constants.dart';

class SerachController extends GetxController {
  RxList<Lead> leadlist = <Lead>[].obs;
  var isFound = true;

  void filterSearchResults(String query) async {
    leadlist.clear();
    var token = storage.read('token');
    final response = await http.get(
      Uri.parse('https://mobile.palace-agency.com/api/findleads'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'tracking': query
      },
    );
    var res = jsonDecode(response.body);

    for (int i = 0; i < res['data'].length; i++) {
      leadlist.add(Lead.fromJson(res['data'][i]));
    }
    if (res['data'].length == 0) {
      isFound = false;
      update();
    }
  }
}
