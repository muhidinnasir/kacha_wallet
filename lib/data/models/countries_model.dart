// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

List<CountriesModel> countriesFromJson(String str) => List<CountriesModel>.from(
    json.decode(str).map((x) => CountriesModel.fromJson(x)));

String countriesToJson(List<CountriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountriesModel {
  String? countryCode;
  String? name;
  String? telephoneCode;

  CountriesModel({
    this.countryCode,
    this.name,
    this.telephoneCode,
  });

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
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
