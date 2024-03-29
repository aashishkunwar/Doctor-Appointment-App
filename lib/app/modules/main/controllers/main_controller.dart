import 'package:ecom_3/app/modules/appointments/views/appointments_view.dart';
import 'package:ecom_3/app/modules/home/views/home_view.dart';
import 'package:ecom_3/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Widget> screens = [
    const HomeView(),
    const AppointmentsView(),
    const ProfileView(),
  ];

  RxInt currentIndex = 0.obs;
}
