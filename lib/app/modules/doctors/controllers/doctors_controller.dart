import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_3/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_3/app/utils/constants.dart';
import 'package:ecom_3/app/utils/memory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class DoctorsController extends GetxController {
  var doctorNameController = TextEditingController();
  var chargeController = TextEditingController();
  var experienceController = TextEditingController();

  XFile? image;
  Uint8List? imageBytes;
  String? specializationId;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addDoctor() async {
    try {
      if (formKey.currentState!.validate()) {
        if (imageBytes == null) {
          showCustomSnackBar(
            message: 'Please select image',
          );
          return;
        }

        var url = Uri.http(ipAddress, 'doctor_appointment_api/addDoctor');

        var request = http.MultipartRequest('POST', url);
        request.fields['token'] = Memory.getToken() ?? '';
        request.fields['name'] = doctorNameController.text;
        request.fields['consultation_charge'] = chargeController.text;
        request.fields['experience'] = experienceController.text;
        request.fields['specialization_id'] = specializationId ?? '';
        request.files.add(http.MultipartFile.fromBytes(
          'avatar',
          imageBytes!,
          filename: image!.name,
        ));

        var response = await request.send();
        var data = await response.stream.bytesToString();
        var result = jsonDecode(data);

        if (result['success']) {
          doctorNameController.clear();
          chargeController.clear();
          experienceController.clear();
          specializationId = null;
          imageBytes = null;
          image = null;
          update();
          Get.back();
          showCustomSnackBar(
            message: result['message'],
            isSuccess: true,
          );

          Get.find<HomeController>().getDoctors();
        } else {
          showCustomSnackBar(
            message: result['message'],
          );
        }
      }
    } catch (e) {
      showCustomSnackBar(
        message: 'Something went wrong',
      );
    }
  }

  void pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      imageBytes = (await image!.readAsBytes());
      update();
    } catch (e) {}
  }

  void deleteDoctor(String doctorId) async {
    try {
      var url = Uri.http(ipAddress, 'doctor_appointment_api/deleteDoctor');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'doctor_id': doctorId,
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.back();
        showCustomSnackBar(
          message: result['message'],
          isSuccess: true,
        );
        await Get.find<HomeController>().getDoctors();
      } else {
        showCustomSnackBar(
          message: result['message'],
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: 'Something went wrong',
      );
    }
  }
}
