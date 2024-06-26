// ignore_for_file: camel_case_types

import 'package:pl_groups/app/modules/login_screen_module/login_screen_controller.dart';
import 'package:get/get.dart';

class loginScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => loginScreenController());
  }
}