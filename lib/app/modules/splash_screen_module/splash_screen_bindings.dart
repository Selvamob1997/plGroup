import 'package:pl_groups/app/modules/splash_screen_module/splash_screen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class splashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => splashScreenController());
  }
}