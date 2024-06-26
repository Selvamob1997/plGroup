import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/routes/routemanagement.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class splashScreenController extends GetxController with GetSingleTickerProviderStateMixin {

  // var _obj = ''.obs;
  // set obj(value) => _obj.value = value;
  // get obj => _obj.value;

  double fontSize = 4;
  double containerSize = 3;
  double textOpacity = 0.0;
  double containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void onInit() {
    super.onInit();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        textOpacity = 1.0;
        update();
      });

    _controller.forward();

    Timer(Duration(seconds: 2), () {
      fontSize = 1.06;
      update();
    });

    Timer(Duration(seconds: 2), () {
      containerSize = 3;
      containerOpacity = 1;
      update();
    });

    Timer(Duration(seconds: 4), () {
      // Navigator.pushReplacement(context, PageTransition(SecondPage));
      Future.delayed(
        const Duration(milliseconds: 10),
            // () => routemanagement.gotodispatch(),
            () => routemanagement.gotologin(),
      );

    });

  }
}
