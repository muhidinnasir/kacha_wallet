// To parse this JSON data, do
//
//     final shipmentInitiateModel = shipmentInitiateModelFromJson(jsonString);

import 'dart:convert';

ShipmentInitiateModel shipmentInitiateModelFromJson(String str) =>
    ShipmentInitiateModel.fromJson(json.decode(str));

String shipmentInitiateModelToJson(ShipmentInitiateModel data) =>
    json.encode(data.toJson());

class ShipmentInitiateModel {
  int? serviceTypeId;
  int? originCityId;
  int? destinationCityId;
  int? originBranchId;
  int? destinationBranchId;
  int? freightTypeId;
  String? originCountryCode;
  String? destinationCountryCode;
  bool? isBulkShipment;

  ShipmentInitiateModel({
    this.serviceTypeId,
    this.originCityId,
    this.destinationCityId,
    this.originBranchId,
    this.destinationBranchId,
    this.freightTypeId,
    this.originCountryCode,
    this.destinationCountryCode,
    this.isBulkShipment,
  });

  factory ShipmentInitiateModel.fromJson(Map<String, dynamic> json) =>
      ShipmentInitiateModel(
        serviceTypeId: json["serviceTypeId"],
        originCityId: json["originCityId"],
        destinationCityId: json["destinationCityId"],
        originBranchId: json["originBranchId"],
        destinationBranchId: json["destinationBranchId"],
        freightTypeId: json["freightTypeId"],
        originCountryCode: json["originCountryCode"],
        destinationCountryCode: json["destinationCountryCode"],
        isBulkShipment: json["isBulkShipment"],
      );

  Map<String, dynamic> toJson() => {
        "serviceTypeId": serviceTypeId,
        "originCityId": originCityId,
        "destinationCityId": destinationCityId,
        "originBranchId": originBranchId,
        "destinationBranchId": destinationBranchId,
        "freightTypeId": freightTypeId,
        "originCountryCode": originCountryCode,
        "destinationCountryCode": destinationCountryCode,
        "isBulkShipment": isBulkShipment,
      };
}
