// To parse this JSON data, do
//
//     final destinationCityModel = destinationCityModelFromJson(jsonString);

import 'dart:convert';

List<DestinationCityModel> destinationCityModelFromJson(String str) =>
    List<DestinationCityModel>.from(
        json.decode(str).map((x) => DestinationCityModel.fromJson(x)));

String destinationCityModelToJson(List<DestinationCityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationCityModel {
  int? id;
  String? name;
  String? countryName;
  String? countryCode;
  String? abbreviatedName;
  String? defaultZipCode;

  DestinationCityModel({
    this.id,
    this.name,
    this.countryName,
    this.countryCode,
    this.abbreviatedName,
    this.defaultZipCode,
  });

  factory DestinationCityModel.fromJson(Map<String, dynamic> json) =>
      DestinationCityModel(
        id: json["id"],
        name: json["name"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        abbreviatedName: json["abbreviatedName"],
        defaultZipCode: json["defaultZipCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "countryName": countryName,
        "countryCode": countryCode,
        "abbreviatedName": abbreviatedName,
        "defaultZipCode": defaultZipCode,
      };
}
