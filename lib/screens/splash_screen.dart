import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_game/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => HomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 232, 253),
      body: Center(
        child: Image.asset(
          'asset/logo/splash.png',
          width: MediaQuery.of(context).size.width * .5,
          height: MediaQuery.of(context).size.width * .5,
        ),
      ),
    );
  }
}
