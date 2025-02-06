import 'package:pl_groups/app/modules/inventory_screen_module/inventory_screen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class InventoryScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InventoryScreenController());
  }
}