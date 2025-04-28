// To parse this JSON data, do
//
//     final origincitiesModel = origincitiesModelFromJson(jsonString);

import 'dart:convert';

OriginCitiesModel origincitiesModelFromJson(String str) =>
    OriginCitiesModel.fromJson(json.decode(str));

String origincitiesModelToJson(OriginCitiesModel data) =>
    json.encode(data.toJson());

class OriginCitiesModel {
  String? countryCode;
  String? countryName;
  String? name;
  dynamic abbreviatedName;
  dynamic defaultZipCode;
  int? id;

  OriginCitiesModel({
    this.countryCode,
    this.countryName,
    this.name,
    this.abbreviatedName,
    this.defaultZipCode,
    this.id,
  });

  factory OriginCitiesModel.fromJson(Map<String, dynamic> json) =>
      OriginCitiesModel(
        countryCode: json["countryCode"],
        countryName: json["countryName"],
        name: json["name"],
        abbreviatedName: json["abbreviatedName"],
        defaultZipCode: json["defaultZipCode"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "countryName": countryName,
        "name": name,
        "abbreviatedName": abbreviatedName,
        "defaultZipCode": defaultZipCode,
        "id": id,
      };
}
