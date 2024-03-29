import 'package:ecom_3/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_3/app/routes/app_pages.dart';
import 'package:ecom_3/app/utils/memory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(AdminHomeController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                Get.toNamed(Routes.NOTIFICATION);
              },
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        body: GetBuilder<AdminHomeController>(
          builder: (controller) {
            if (controller.statsResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Wrap(children: [
              SizedBox(
                height: 50,
                width: Get.width,
              ),
              Center(
                child: Lottie.asset(
                  'assets/lottie/dashboard.json',
                  height: 200,
                  repeat: true,
                ),
              ),
              SizedBox(
                height: 50,
                width: Get.width,
              ),
              StatsCard(
                title: 'Doctors',
                value: controller.statsResponse!.stats?.noOfDoctors ?? '',
                color: Colors.blue,
              ),
              Visibility(
                visible: Memory.getRole() == 'admin',
                child: StatsCard(
                  title: 'No of Users',
                  value: controller.statsResponse!.stats?.totalUsers ?? '',
                  color: Colors.green,
                ),
              ),
              StatsCard(
                title: 'Appointments',
                value: controller.statsResponse!.stats?.totalAppointments ?? '',
                color: Colors.red,
              ),
              StatsCard(
                title: 'Total Monthly Income',
                value:
                    "Rs.${controller.statsResponse!.stats?.totalMonthlyIncome}" ??
                        '',
                color: Colors.orange,
              ),
              StatsCard(
                title: 'Total Income',
                value:
                    "Rs.${controller.statsResponse!.stats?.totalIncome}" ?? '',
                color: Colors.orange,
              ),
            ]);
          },
        ));
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const StatsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: Get.width * 0.48,
        height: 150,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
