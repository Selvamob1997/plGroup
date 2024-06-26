

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'app_pages.dart';

abstract class routemanagement {

  static void gotosplash() {
    Get.offNamed(Routes.SPLASH_SCREEN);
  }

  static void gotologin() {
    Get.offNamed(Routes.LOGIN_SCREEN);
  }


  static void gotodashBoard() {
    Get.offNamed(Routes.DASH_BOARD);
  }

  static void gotoPacking() {
    Get.toNamed(Routes.PACKING_SCREEN);
  }
  static void gotoDispatched() {
    Get.toNamed(Routes.DISPATCHED);
  }

}