import 'package:ecom_3/app/models/doctor.dart';
import 'package:ecom_3/app/modules/doctor_detail/views/doctor_detail_view.dart';
import 'package:ecom_3/app/routes/app_pages.dart';
import 'package:ecom_3/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final bool showAnimation;
  const DoctorCard(
      {super.key, required this.doctor, this.showAnimation = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ]),
      child: Row(
        children: [
          Expanded(
            child: showAnimation
                ? Hero(
                    tag: doctor.id!,
                    child: Image.network(
                      getImageUrl(doctor.avatar),
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  )
                : Image.network(
                    getImageUrl(doctor.avatar),
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.name ?? '',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(doctor.title ?? '', style: TextStyle(fontSize: 16)),
                Text(doctor.name ?? '', style: TextStyle(fontSize: 16)),
                Text(doctor.address ?? ''),
                Text(doctor.email ?? ''),
                Text(
                  "Fees: Rs.${doctor.consultationCharge}" ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //view doctor button
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.DOCTOR_DETAIL, arguments: doctor);
                  },
                  child: Text('View Doctor'),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
