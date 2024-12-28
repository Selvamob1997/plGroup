import 'package:pl_groups/app/modules/scaning_qrcode_module/scaning_qrcode_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ScaningQrcodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScaningQrcodeController());
  }
}