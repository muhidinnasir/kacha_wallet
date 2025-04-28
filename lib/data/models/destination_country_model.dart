// To parse this JSON data, do
//
//     final destinationCountryModel = destinationCountryModelFromJson(jsonString);

import 'dart:convert';

CountryModel destinationCountryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String destinationCountryModelToJson(CountryModel data) =>
    json.encode(data.toJson());

class CountryModel {
  String? countryCode;
  String? name;
  String? telephoneCode;
  bool isLoading = false;

  CountryModel({
    this.countryCode,
    this.name,
    this.telephoneCode,
    this.isLoading = false,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        countryCode: json["countryCode"],
        name: json["name"],
        telephoneCode: json["telephoneCode"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "name": name,
        "telephoneCode": telephoneCode,
      };
}
