import 'dart:async';
import 'package:get/get.dart';
import 'package:shortie/routes/app_routes.dart';
import 'package:shortie/pages/splash_screen_page/api/admin_setting_api.dart';
import 'package:shortie/utils/branch_io_services.dart';
import 'package:shortie/utils/database.dart';
import 'package:shortie/utils/enums.dart';
import 'package:shortie/utils/internet_connection.dart';
import 'package:shortie/utils/request.dart';
import 'package:shortie/utils/utils.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {

    print("Splash Screen Controller");

    await AppRequest.notificationPermission();

    print("Splash Screen Controller 1");

    if (InternetConnection.isConnect.value) {

      print("Splash Screen Controller 2");

     await AdminSettingsApi.callApi(); // Get Admin Setting Data...

      print("Splash Screen Controller 3");

      if (AdminSettingsApi.adminSettingModel?.data != null) {

        print("Splash Screen Controller 4");
        await Utils.onInitCreateEngine(); // Init Live...
        print("Splash Screen Controller 5");
        await Utils.onInitPayment(); // Init Payment...
        print("Splash Screen Controller 6");
        await splashScreen();
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
        Utils.showLog("Admin Setting Api Calling Failed !!");
      }
    } else {
      Utils.showToast(EnumLocal.txtConnectionLost.name.tr);
      Utils.showLog("Internet Connection Lost !!");
    }
  }

  Future<void> splashScreen() async {
    Timer(
      Duration(milliseconds: 100),
      () {
        // Check User Is Login Or Not...
        if (Database.isNewUser == false && Database.fetchLoginUserProfileModel?.user?.id != null) {
          //BranchIoServices.onListenBranchIoLinks();
          Get.offAllNamed(AppRoutes.bottomBarPage);
        } else {
          Get.offAllNamed(AppRoutes.loginPage);
        }
      },
    );
  }
}
