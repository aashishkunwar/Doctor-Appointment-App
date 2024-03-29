import 'package:get/get.dart';
import 'package:flutter/material.dart';

const ipAddress = '192.168.1.66';

MaterialColor primaryColor = Colors.purple;
var getImageUrl = (imageUrl) {
  return 'http://$ipAddress/doctor_appointment_api/$imageUrl'; //doctor_appointment_api
};

var showCustomSnackBar = ({
  required String message,
  bool isSuccess = false,
}) =>
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        // borderRadius: 10.w,
        snackPosition: SnackPosition.TOP,
      ),
    );
