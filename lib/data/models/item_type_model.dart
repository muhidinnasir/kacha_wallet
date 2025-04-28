// To parse this JSON data, do
//
//     final itemTypesModel = itemTypesModelFromJson(jsonString);

import 'dart:convert';

List<ItemTypesModel> itemTypesModelFromJson(String str) =>
    List<ItemTypesModel>.from(
        json.decode(str).map((x) => ItemTypesModel.fromJson(x)));

String itemTypesModelToJson(List<ItemTypesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemTypesModel {
  int? id;
  String? name;
  dynamic description;

  ItemTypesModel({
    this.id,
    this.name,
    this.description,
  });

  factory ItemTypesModel.fromJson(Map<String, dynamic> json) => ItemTypesModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
