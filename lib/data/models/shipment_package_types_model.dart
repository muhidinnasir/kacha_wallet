// To parse this JSON data, do
//
//     final shipmentPackageTypesModel = shipmentPackageTypesModelFromJson(jsonString);

import 'dart:convert';

List<ShipmentPackageTypesModel> shipmentPackageTypesModelFromJson(String str) =>
    List<ShipmentPackageTypesModel>.from(
        json.decode(str).map((x) => ShipmentPackageTypesModel.fromJson(x)));

String shipmentPackageTypesModelToJson(List<ShipmentPackageTypesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShipmentPackageTypesModel {
  String? name;
  int? unitOfMeasureId;
  String? unitOfMeasureName;
  int? width;
  int? height;
  int? length;
  String? description;
  int? id;

  ShipmentPackageTypesModel({
    this.name,
    this.unitOfMeasureId,
    this.unitOfMeasureName,
    this.width,
    this.height,
    this.length,
    this.description,
    this.id,
  });

  factory ShipmentPackageTypesModel.fromJson(Map<String, dynamic> json) =>
      ShipmentPackageTypesModel(
        name: json["name"],
        unitOfMeasureId: json["unitOfMeasureId"],
        unitOfMeasureName: json["unitOfMeasureName"],
        width: json["width"],
        height: json["height"],
        length: json["length"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "unitOfMeasureId": unitOfMeasureId,
        "unitOfMeasureName": unitOfMeasureName,
        "width": width,
        "height": height,
        "length": length,
        "description": description,
        "id": id,
      };
}
