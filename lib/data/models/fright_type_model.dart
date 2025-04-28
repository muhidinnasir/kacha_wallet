// To parse this JSON data, do
//
//     final freightTypeModel = freightTypeModelFromJson(jsonString);

import 'dart:convert';

List<FreightTypeModel> freightTypeModelFromJson(String str) =>
    List<FreightTypeModel>.from(
        json.decode(str).map((x) => FreightTypeModel.fromJson(x)));

String freightTypeModelToJson(List<FreightTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FreightTypeModel {
  int? freightTypeId;
  String? freightTypeName;
  bool? isDefault;

  FreightTypeModel({
    this.freightTypeId,
    this.freightTypeName,
    this.isDefault,
  });

  factory FreightTypeModel.fromJson(Map<String, dynamic> json) =>
      FreightTypeModel(
        freightTypeId: json["freightTypeId"],
        freightTypeName: json["freightTypeName"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "freightTypeId": freightTypeId,
        "freightTypeName": freightTypeName,
        "isDefault": isDefault,
      };
}
