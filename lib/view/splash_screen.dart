import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_converter/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
        child: Column(
          children: [

           Image.asset(
            "assets/images/welcome.png",
            fit: BoxFit.cover,
           )
          ],
        ),
      ),
    );
  }
}
