import 'package:get/get.dart';
import 'package:shortie/pages/splash_screen_page/controller/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
