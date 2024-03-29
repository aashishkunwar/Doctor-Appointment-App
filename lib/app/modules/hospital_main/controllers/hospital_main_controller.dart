import 'package:ecom_3/app/modules/admin_home/views/admin_home_view.dart';
import 'package:ecom_3/app/modules/appointments/views/appointments_view.dart';
import 'package:ecom_3/app/modules/doctors/views/doctors_view.dart';
import 'package:ecom_3/app/modules/home/views/home_view.dart';
import 'package:ecom_3/app/modules/hostpital_home/views/hostpital_home_view.dart';
import 'package:ecom_3/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalMainController extends GetxController {
  List<Widget> screens = [
    AdminHomeView(),
    AppointmentsView(),
    DoctorsView(),
    ProfileView(),
  ];

  RxInt currentIndex = 0.obs;
}
