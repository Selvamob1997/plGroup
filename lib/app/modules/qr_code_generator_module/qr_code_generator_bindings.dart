import 'package:pl_groups/app/modules/qr_code_generator_module/qr_code_generator_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class QrCodeGeneratorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrCodeGeneratorController());
  }
}