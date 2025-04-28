// To parse this JSON data, do
//
//     final destinationBranchModel = destinationBranchModelFromJson(jsonString);

import 'dart:convert';

List<DestinationBranchModel> destinationBranchModelFromJson(String str) =>
    List<DestinationBranchModel>.from(
        json.decode(str).map((x) => DestinationBranchModel.fromJson(x)));

String destinationBranchModelToJson(List<DestinationBranchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationBranchModel {
  int? companyId;
  int? cityId;
  int? defaultCurrencyId;
  String? defaultCurrencyName;
  String? defaultCurrencyCode;
  String? defaultCurrencySymbol;
  String? countryCode;
  String? country;
  String? city;
  bool? isHeadOffice;
  String? name;
  String? airportCode;
  String? internalCode;
  String? phone;
  String? addressLine;
  String? subcity;
  String? dispatchBranchId;
  List<dynamic>? branchTypes;
  String? id;
  String? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  DestinationBranchModel({
    this.companyId,
    this.cityId,
    this.defaultCurrencyId,
    this.defaultCurrencyName,
    this.defaultCurrencyCode,
    this.defaultCurrencySymbol,
    this.countryCode,
    this.country,
    this.city,
    this.isHeadOffice,
    this.name,
    this.airportCode,
    this.internalCode,
    this.phone,
    this.addressLine,
    this.subcity,
    this.dispatchBranchId,
    this.branchTypes,
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory DestinationBranchModel.fromJson(Map<String, dynamic> json) =>
      DestinationBranchModel(
        companyId: json["companyId:"],
        cityId: json["cityId"],
        defaultCurrencyId: json["defaultCurrencyId"],
        defaultCurrencyName: json["defaultCurrencyName"],
        defaultCurrencyCode: json["defaultCurrencyCode"],
        defaultCurrencySymbol: json["defaultCurrencySymbol"],
        countryCode: json["countryCode"],
        country: json["country"],
        city: json["city"],
        isHeadOffice: json["isHeadOffice"],
        name: json["name"],
        airportCode: json["airportCode"],
        internalCode: json["internalCode"],
        phone: json["phone"],
        addressLine: json["addressLine"],
        subcity: json["subcity"],
        dispatchBranchId: json["dispatchBranchId"],
        branchTypes: json["branchTypes:"] == null
            ? []
            : List<dynamic>.from(json["branchTypes:"]!.map((x) => x)),
        id: json["id"].toString(),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "companyId:": companyId,
        "cityId": cityId,
        "defaultCurrencyId": defaultCurrencyId,
        "defaultCurrencyName": defaultCurrencyName,
        "defaultCurrencyCode": defaultCurrencyCode,
        "defaultCurrencySymbol": defaultCurrencySymbol,
        "countryCode": countryCode,
        "country": country,
        "city": city,
        "isHeadOffice": isHeadOffice,
        "name": name,
        "airportCode": airportCode,
        "internalCode": internalCode,
        "phone": phone,
        "addressLine": addressLine,
        "subcity": subcity,
        "dispatchBranchId": dispatchBranchId,
        "branchTypes:": branchTypes == null
            ? []
            : List<dynamic>.from(branchTypes!.map((x) => x)),
        "id": id,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
