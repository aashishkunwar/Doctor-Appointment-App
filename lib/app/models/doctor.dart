// To parse this JSON data, do
//
//     final doctorsResponse = doctorsResponseFromJson(jsonString);

import 'dart:convert';

DoctorsResponse doctorsResponseFromJson(String str) =>
    DoctorsResponse.fromJson(json.decode(str));

String doctorsResponseToJson(DoctorsResponse data) =>
    json.encode(data.toJson());

class DoctorsResponse {
  final bool success;
  final String message;
  final List<Doctor> doctors;

  DoctorsResponse({
    required this.success,
    required this.message,
    required this.doctors,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) =>
      DoctorsResponse(
        success: json["success"],
        message: json["message"],
        doctors:
            List<Doctor>.from(json["doctors"].map((x) => Doctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "doctors": List<dynamic>.from(doctors.map((x) => x.toJson())),
      };
}

class Doctor {
  final String id;
  final String name;
  final String consultationCharge;
  final String specializationId;
  final String avatar;
  final String experience;
  final String hospitalId;
  final String isDeleted;
  final String title;
  final String fullName;
  final String email;
  final String address;

  Doctor({
    required this.id,
    required this.name,
    required this.consultationCharge,
    required this.specializationId,
    required this.avatar,
    required this.experience,
    required this.hospitalId,
    required this.isDeleted,
    required this.title,
    required this.fullName,
    required this.email,
    required this.address,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        consultationCharge: json["consultation_charge"],
        specializationId: json["specialization_id"],
        avatar: json["avatar"],
        experience: json["experience"],
        hospitalId: json["hospital_id"],
        isDeleted: json["isDeleted"],
        title: json["title"],
        fullName: json["full_name"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "consultation_charge": consultationCharge,
        "specialization_id": specializationId,
        "avatar": avatar,
        "experience": experience,
        "hospital_id": hospitalId,
        "isDeleted": isDeleted,
        "title": title,
        "full_name": fullName,
        "email": email,
        "address": address,
      };
}
