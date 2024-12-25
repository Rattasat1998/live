import 'package:get/get.dart';
import 'package:shortie/pages/fake_chat_page/controller/fake_chat_controller.dart';

class FakeChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FakeChatController>(() => FakeChatController());
  }
}