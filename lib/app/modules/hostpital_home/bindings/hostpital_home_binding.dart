import 'package:get/get.dart';

import '../controllers/hostpital_home_controller.dart';

class HostpitalHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostpitalHomeController>(
      () => HostpitalHomeController(),
    );
  }
}
