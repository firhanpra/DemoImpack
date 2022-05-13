import 'package:demo_impack_pratama/pages/home_page/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isShow = false;
  var opacityLevel = 0.0.obs;

  @override
  void initState() {
    //Animate splash screen
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      opacityLevel.value = 1.0;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.offAll(() => HomePage());
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Obx(
          () => AnimatedOpacity(
            opacity: opacityLevel.value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
            child: SizedBox(
                width: Get.width * 0.7,
                child: Image.asset(
                  'assets/impack.png',
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
