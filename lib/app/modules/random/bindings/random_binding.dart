import 'package:get/get.dart';

import '../controllers/random_controller.dart';

class RandomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RandomController>(
      () => RandomController(),
    );
  }
}
