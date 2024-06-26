import 'package:pl_groups/app/modules/dispatched_module/dispatched_controller.dart';
import 'package:get/get.dart';


class DispatchedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DispatchedController());
  }
}