import 'package:get/get.dart';
import 'package:shortie/pages/setting_page/controller/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}