// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/animation.dart';
import 'package:get_storage/get_storage.dart';

List<Map> collection = [];
List<Map> collection2 = [];
final storage = GetStorage();
var database;
var user = [];
var deals = [];
var types = [
  'Delivered',
  'Ready to ship',
  'Canceled',
  'Return',
  'Not Delivered',
  'Shipped'
];

List colors = [
  const Color(0xffc19da9),
  const Color(0xff79b29f),
  const Color(0xff99afc7),
  const Color(0xffc1b29d),
  const Color(0xffefc394),
  const Color(0xffc19cc7),
];
List assets = [
  "assets/icons/delivred.svg",
  "assets/icons/alldeals.svg",
  "assets/icons/changestate.svg",
  "assets/icons/returned.svg",
  "assets/icons/postponed.svg",
  "assets/icons/shiped.svg",
];
