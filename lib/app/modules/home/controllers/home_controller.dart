import 'package:ecom_3/app/models/doctor.dart';
import 'package:ecom_3/app/models/specalization.dart';
import 'package:ecom_3/app/utils/constants.dart';
import 'package:ecom_3/app/utils/memory.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  SpecializationResponse? specializationResponse;
  DoctorsResponse? doctorsResponse;

  @override
  void onInit() {
    super.onInit();
    getSpecializations();
    getDoctors();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getSpecializations() async {
    try {
      var url = Uri.http(ipAddress, 'doctor_appointment_api/getSpecialization');

      var response = await http.post(url, body: {"token": Memory.getToken()});
      specializationResponse = specializationResponseFromJson(response.body);
      update();

      if (specializationResponse?.success ?? false) {
        // showCustomSnackBar(
        //   message: specializationResponse?.message ?? '',
        //   isSuccess: true,
        // );
      } else {
        showCustomSnackBar(
          message: specializationResponse?.message ?? '',
        );
      }
    } catch (e) {
      print(e);
      showCustomSnackBar(
        message: 'Something went wrong',
      );
    }
  }

  Future<void> getDoctors() async {
    try {
      var url = Uri.http(ipAddress, 'doctor_api/getDoctors');

      var response = await http.post(url, body: {"token": Memory.getToken()});
      doctorsResponse = doctorsResponseFromJson(response.body);
      update();

      if (specializationResponse?.success ?? false) {
      } else {
        showCustomSnackBar(
          message: specializationResponse?.message ?? '',
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: 'Something went wrong',
      );
    }
  }
}
