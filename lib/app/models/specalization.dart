// To parse this JSON data, do
//
//     final specializationResponse = specializationResponseFromJson(jsonString);

import 'dart:convert';

SpecializationResponse specializationResponseFromJson(String str) =>
    SpecializationResponse.fromJson(json.decode(str));

String specializationResponseToJson(SpecializationResponse data) =>
    json.encode(data.toJson());

class SpecializationResponse {
  final bool? success;
  final String? message;
  final List<Specalization>? specalizations;

  SpecializationResponse({
    this.success,
    this.message,
    this.specalizations,
  });

  factory SpecializationResponse.fromJson(Map<String, dynamic> json) =>
      SpecializationResponse(
        success: json["success"],
        message: json["message"],
        specalizations: json["specalizations"] == null
            ? []
            : List<Specalization>.from(
                json["specalizations"]!.map((x) => Specalization.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "specalizations": specalizations == null
            ? []
            : List<dynamic>.from(specalizations!.map((x) => x.toJson())),
      };
}

class Specalization {
  final String? specializationId;
  final String? title;

  Specalization({
    this.specializationId,
    this.title,
  });

  factory Specalization.fromJson(Map<String, dynamic> json) => Specalization(
        specializationId: json["specialization_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "specialization_id": specializationId,
        "title": title,
      };
}
