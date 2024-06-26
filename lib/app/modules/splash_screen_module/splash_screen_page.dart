// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/modules/splash_screen_module/splash_screen_controller.dart';
import 'package:pl_groups/app/utils/stringValues.dart';
import '../../theme/colors_value.dart';
import '../../utils/dimens.dart';

class splashScreenPage extends GetView<splashScreenController> {
  const splashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height =  MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<splashScreenController> (builder: (splashCntrlr){
      return Scaffold(
        backgroundColor: ColorsValue.primaryColor,
        body: Stack(
          children: [
            Column(
              children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: height / splashCntrlr.fontSize
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 1000),
                  opacity: splashCntrlr.textOpacity,
                  child: Text(
                    // 'M N AUTO',
                    stringValues.plgroups,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: splashCntrlr.animation1.value,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                opacity: splashCntrlr.containerOpacity,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    // height: _width / _spalshnew_cntrlr.containerSize,
                    height: height / Dimens.six,
                    width: width / splashCntrlr.containerSize,
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    // child: Image.asset('assets/images/file_name.png')
                    // child: Text(
                    //   'YOUR APP\'S LOGO',
                    // ),
                    child: Image.asset("assets/pllogo.png",
                      width: Get.height/8,
                      height: Get.width,
                    )
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
