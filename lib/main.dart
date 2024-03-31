import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GuessNumberApp());
}

class GuessNumberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: null,
    );
  }
}
