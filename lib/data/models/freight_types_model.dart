// To parse this JSON data, do
//
//     final freightTypesModel = freightTypesModelFromJson(jsonString);

import 'dart:convert';

List<FreightTypesModel> freightTypesModelFromJson(String str) =>
    List<FreightTypesModel>.from(
        json.decode(str).map((x) => FreightTypesModel.fromJson(x)));

String freightTypesModelToJson(List<FreightTypesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FreightTypesModel {
  String? name;
  String? description;
  int? id;

  FreightTypesModel({
    this.name,
    this.description,
    this.id,
  });

  factory FreightTypesModel.fromJson(Map<String, dynamic> json) =>
      FreightTypesModel(
        name: json["name"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "id": id,
      };
}
