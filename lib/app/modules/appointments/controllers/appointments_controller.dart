import 'package:ecom_3/app/models/appointment.dart';
import 'package:ecom_3/app/utils/constants.dart';
import 'package:ecom_3/app/utils/memory.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppointmentsController extends GetxController {
  AppointmentResponse? appointmentResponse;

  @override
  void onInit() {
    super.onInit();
    getMyDetails();
  }

  void getMyDetails() async {
    try {
      Uri url = Uri.http(ipAddress, 'doctor_appointment_api/getAppointments');

      var response = await http.post(url, body: {"token": Memory.getToken()});

      // print(response.body);

      var result = appointmentResponseFromJson(response.body);

      if (result.success ?? false) {
        appointmentResponse = result;
        update();
      } else {
        showCustomSnackBar(
          message: result.message ?? '',
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: e.toString(),
      );
    }
  }
}
