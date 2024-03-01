import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: Top SnackBar
showError({
  String title = "",
  String description = "",
  SnackPosition position = SnackPosition.TOP,
}) {
  Get.snackbar(
    title,
    description,
    colorText: Colors.white,
    backgroundColor: Colors.blueAccent,
    snackPosition: position,
    barBlur: 0,
  );
}

//TODO: Bottom SnackBar
showSnackBar({
  String title = "",
  String description = "",
  int durationSec = 2,
}) {
  Get.showSnackbar(GetSnackBar(
    title: title,
    message: description,
    duration: Duration(seconds: durationSec),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Color(0xfff71921),
  ));
}
