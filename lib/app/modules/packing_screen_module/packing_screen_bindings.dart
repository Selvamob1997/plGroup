import 'package:pl_groups/app/modules/packing_screen_module/packing_screen_controller.dart';
import 'package:get/get.dart';


class packingScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => packingScreenController());
  }
}