import 'dart:convert';

import 'package:ecom_3/app/models/doctor.dart';
import 'package:ecom_3/app/routes/app_pages.dart';
import 'package:ecom_3/app/utils/constants.dart';
import 'package:ecom_3/app/utils/memory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khalti_flutter/khalti_flutter.dart';

class DoctorDetailController extends GetxController {
  final Doctor doctor = Get.arguments as Doctor;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var problemsController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void makeBooking() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      Uri url = Uri.http(ipAddress, 'doctor_appointment_api/makeAppointment');
      var response = await http.post(
        url,
        body: {
          'token': Memory.getToken() ?? '',
          'doctor_id': doctor.id.toString(),
          'date': "${dateController.text} ${timeController.text}",
          'problems': problemsController.text,
        },
      );

      var result = jsonDecode(response.body);
      if (result['success']) {
        makePayment(result['appointment_id'].toString());
      } else {
        showCustomSnackBar(
          message: result['message'],
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: e.toString(),
      );
    }
  }

  void makePayment(String appointmentId) {
    try {
      PaymentConfig config = PaymentConfig(
        productName: "Appointment",
        // amount: int.parse(doctor.consultationCharge??'0')*100,
        amount: 100 * 100,
        productIdentity: appointmentId,
      );
      KhaltiScope.of(Get.context!).pay(
          config: config,
          preferences: [PaymentPreference.khalti],
          onSuccess: (v) async {
            Uri url = Uri.http(ipAddress, 'doctor_appointment_api/makePayment');
            var response = await http.post(url, body: {
              'token': Memory.getToken() ?? '',
              'appointmentId': appointmentId,
              'amount': doctor.consultationCharge ?? '0',
              'details': v.toString()
            });

            var result = jsonDecode(response.body);

            if (result['success']) {
              showCustomSnackBar(
                  message: 'Payment Successful', isSuccess: true);
              Get.offAllNamed(Routes.MAIN);
            } else {
              showCustomSnackBar(message: result['message']);
            }
          },
          onFailure: (v) {
            showCustomSnackBar(message: v.message);
          });
    } catch (e) {
      showCustomSnackBar(message: e.toString());
    }
  }
}
