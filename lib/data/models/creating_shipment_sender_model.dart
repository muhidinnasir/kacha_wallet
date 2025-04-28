// To parse this JSON data, do
//
//     final senderShipmentDetailModel = senderShipmentDetailModelFromJson(jsonString);

import 'dart:convert';

SenderShipmentDetailModel senderShipmentDetailModelFromJson(String str) =>
    SenderShipmentDetailModel.fromJson(json.decode(str));

String senderShipmentDetailModelToJson(SenderShipmentDetailModel data) =>
    json.encode(data.toJson());

class SenderShipmentDetailModel {
  String? orderId;
  String? companyName;
  String? firstName;
  String? lastName;
  String? countryCode;
  int? cityId;
  String? subcity;
  String? houseNumber;
  String? phoneNumber;
  String? email;
  dynamic notifyReceiver;

  SenderShipmentDetailModel({
    this.orderId,
    this.companyName,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.cityId,
    this.subcity,
    this.houseNumber,
    this.phoneNumber,
    this.email,
    this.notifyReceiver,
  });

  factory SenderShipmentDetailModel.fromJson(Map<String, dynamic> json) =>
      SenderShipmentDetailModel(
        orderId: json["orderId"],
        companyName: json["companyName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        countryCode: json["countryCode"],
        cityId: json["cityId"],
        subcity: json["subcity"],
        houseNumber: json["houseNumber"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        notifyReceiver: json["notifyReceiver"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "companyName": companyName,
        "firstName": firstName,
        "lastName": lastName,
        "countryCode": countryCode,
        "cityId": cityId,
        "subcity": subcity,
        "houseNumber": houseNumber,
        "phoneNumber": phoneNumber,
        "email": email,
        "notifyReceiver": notifyReceiver,
      };
}
