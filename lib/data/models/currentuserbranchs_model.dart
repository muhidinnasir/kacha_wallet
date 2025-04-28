// To parse this JSON data, do
//
//     final currentUserBranchesModel = currentUserBranchesModelFromJson(jsonString);

import 'dart:convert';

List<CurrentUserBranchesModel> currentUserBranchesModelFromJson(String str) =>
    List<CurrentUserBranchesModel>.from(
        json.decode(str).map((x) => CurrentUserBranchesModel.fromJson(x)));

String currentUserBranchesModelToJson(List<CurrentUserBranchesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrentUserBranchesModel {
  int? companyId;
  int? cityId;
  int? defaultCurrencyId;
  String? defaultCurrencyName;
  String? defaultCurrencyCode;
  String? defaultCurrencySymbol;
  String? countryCode;
  String? country;
  String? city;
  String? name;
  String? airportCode;
  String? internalCode;
  String? phone;
  String? addressLine;
  dynamic subcity;
  bool? isHeadOffice;
  dynamic dispatchBranchId;
  List<int>? branchTypes;
  int? id;
  String? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  dynamic updatedAt;

  CurrentUserBranchesModel({
    this.companyId,
    this.cityId,
    this.defaultCurrencyId,
    this.defaultCurrencyName,
    this.defaultCurrencyCode,
    this.defaultCurrencySymbol,
    this.countryCode,
    this.country,
    this.city,
    this.name,
    this.airportCode,
    this.internalCode,
    this.phone,
    this.addressLine,
    this.subcity,
    this.isHeadOffice,
    this.dispatchBranchId,
    this.branchTypes,
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory CurrentUserBranchesModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserBranchesModel(
        companyId: json["companyId"],
        cityId: json["cityId"],
        defaultCurrencyId: json["defaultCurrencyId"],
        defaultCurrencyName: json["defaultCurrencyName"],
        defaultCurrencyCode: json["defaultCurrencyCode"],
        defaultCurrencySymbol: json["defaultCurrencySymbol"],
        countryCode: json["countryCode"],
        country: json["country"],
        city: json["city"],
        name: json["name"],
        airportCode: json["airportCode"],
        internalCode: json["internalCode"],
        phone: json["phone"],
        addressLine: json["addressLine"],
        subcity: json["subcity"],
        isHeadOffice: json["isHeadOffice"],
        dispatchBranchId: json["dispatchBranchId"],
        branchTypes: json["branchTypes"] == null
            ? []
            : List<int>.from(json["branchTypes"]!.map((x) => x)),
        id: json["id"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "cityId": cityId,
        "defaultCurrencyId": defaultCurrencyId,
        "defaultCurrencyName": defaultCurrencyName,
        "defaultCurrencyCode": defaultCurrencyCode,
        "defaultCurrencySymbol": defaultCurrencySymbol,
        "countryCode": countryCode,
        "country": country,
        "city": city,
        "name": name,
        "airportCode": airportCode,
        "internalCode": internalCode,
        "phone": phone,
        "addressLine": addressLine,
        "subcity": subcity,
        "isHeadOffice": isHeadOffice,
        "dispatchBranchId": dispatchBranchId,
        "branchTypes": branchTypes == null
            ? []
            : List<dynamic>.from(branchTypes!.map((x) => x)),
        "id": id,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt,
      };
}
