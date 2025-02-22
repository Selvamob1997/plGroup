import '../../app/modules/inventory_screen_module/inventory_screen_page.dart';
import '../../app/modules/inventory_screen_module/inventory_screen_bindings.dart';
import '../../app/modules/qr_code_generator_module/qr_code_generator_page.dart';
import '../../app/modules/qr_code_generator_module/qr_code_generator_bindings.dart';
import '../../app/modules/scaning_qrcode_module/scaning_qrcode_page.dart';
import '../../app/modules/scaning_qrcode_module/scaning_qrcode_bindings.dart';
import '../../app/modules/dispatched_module/dispatched_page.dart';
import '../../app/modules/dispatched_module/dispatched_bindings.dart';
import '../../app/modules/dash_board_module/dash_board_page.dart';
import '../../app/modules/dash_board_module/dash_board_bindings.dart';
import '../../app/modules/packing_screen_module/packing_screen_page.dart';
import '../../app/modules/packing_screen_module/packing_screen_bindings.dart';
import '../../app/modules/login_screen_module/login_screen_page.dart';
import '../../app/modules/login_screen_module/login_screen_bindings.dart';
import '../../app/modules/splash_screen_module/splash_screen_bindings.dart';
import '../../app/modules/splash_screen_module/splash_screen_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {

  static var initialpage = Routes.SPLASH_SCREEN;

  static final pages = [
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => splashScreenPage(),
      binding: splashScreenBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => loginScreenPage(),
      binding: loginScreenBinding(),
    ),
    GetPage(
      name: Routes.PACKING_SCREEN,
      page: () => packingScreenPage(),
      binding: packingScreenBinding(),
    ),
    GetPage(
      name: Routes.DASH_BOARD,
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: Routes.DISPATCHED,
      page: () => DispatchedPage(),
      binding: DispatchedBinding(),
    ),
    GetPage(
      name: Routes.SCANING_QRCODE,
      page: () => ScaningQrcodePage(),
      binding: ScaningQrcodeBinding(),
    ),
    GetPage(
      name: Routes.QR_CODE_GENERATOR,
      page: () => QrCodeGeneratorPage(),
      binding: QrCodeGeneratorBinding(),
    ),
    GetPage(
      name: Routes.INVENTORY_SCREEN,
      page: () => InventoryScreenPage(),
      binding: InventoryScreenBinding(),
    ),
  ];
}
