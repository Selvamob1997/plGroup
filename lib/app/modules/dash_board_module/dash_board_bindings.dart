import 'package:pl_groups/app/modules/dash_board_module/dash_board_controller.dart';
import 'package:get/get.dart';


class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
  }
}