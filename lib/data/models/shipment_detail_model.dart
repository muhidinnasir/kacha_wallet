// To parse this JSON data, do
//
//     final shipmentDetailModel = shipmentDetailModelFromJson(jsonString);

import 'dart:convert';

ShipmentDetailModel shipmentDetailModelFromJson(String str) =>
    ShipmentDetailModel.fromJson(json.decode(str));

String shipmentDetailModelToJson(ShipmentDetailModel data) =>
    json.encode(data.toJson());

class ShipmentDetailModel {
  String? id;
  bool? draft;
  bool? isBulkShipment;
  int? serviceTypeId;
  int? freightTypeId;
  dynamic trackingNumber;
  int? totalWeight;
  double? totalVWeight;
  int? totalChargeableWeight;
  Type? serviceType;
  Type? freightType;
  Route? route;
  Recipient? sender;
  Recipient? recipient;
  dynamic paymentAmountInfo;
  dynamic payment;
  List<Item>? items;

  ShipmentDetailModel({
    this.id,
    this.draft,
    this.isBulkShipment,
    this.serviceTypeId,
    this.freightTypeId,
    this.trackingNumber,
    this.totalWeight,
    this.totalVWeight,
    this.totalChargeableWeight,
    this.serviceType,
    this.freightType,
    this.route,
    this.sender,
    this.recipient,
    this.paymentAmountInfo,
    this.payment,
    this.items,
  });

  ShipmentDetailModel copyWith({
    String? id,
    bool? draft,
    bool? isBulkShipment,
    int? serviceTypeId,
    int? freightTypeId,
    dynamic trackingNumber,
    int? totalWeight,
    double? totalVWeight,
    int? totalChargeableWeight,
    Type? serviceType,
    Type? freightType,
    Route? route,
    Recipient? sender,
    Recipient? recipient,
    dynamic paymentAmountInfo,
    dynamic payment,
    List<Item>? items,
  }) =>
      ShipmentDetailModel(
        id: id ?? this.id,
        draft: draft ?? this.draft,
        isBulkShipment: isBulkShipment ?? this.isBulkShipment,
        serviceTypeId: serviceTypeId ?? this.serviceTypeId,
        freightTypeId: freightTypeId ?? this.freightTypeId,
        trackingNumber: trackingNumber ?? this.trackingNumber,
        totalWeight: totalWeight ?? this.totalWeight,
        totalVWeight: totalVWeight ?? this.totalVWeight,
        totalChargeableWeight:
            totalChargeableWeight ?? this.totalChargeableWeight,
        serviceType: serviceType ?? this.serviceType,
        freightType: freightType ?? this.freightType,
        route: route ?? this.route,
        sender: sender ?? this.sender,
        recipient: recipient ?? this.recipient,
        paymentAmountInfo: paymentAmountInfo ?? this.paymentAmountInfo,
        payment: payment ?? this.payment,
        items: items ?? this.items,
      );

  factory ShipmentDetailModel.fromJson(Map<String, dynamic> json) =>
      ShipmentDetailModel(
        id: json["id"],
        draft: json["draft"],
        isBulkShipment: json["isBulkShipment"],
        serviceTypeId: json["serviceTypeId"],
        freightTypeId: json["freightTypeId"],
        trackingNumber: json["trackingNumber"],
        totalWeight: json["totalWeight"],
        totalVWeight: json["totalVWeight"]?.toDouble(),
        totalChargeableWeight: json["totalChargeableWeight"],
        serviceType: json["serviceType"] == null
            ? null
            : Type.fromJson(json["serviceType"]),
        freightType: json["freightType"] == null
            ? null
            : Type.fromJson(json["freightType"]),
        route: json["route"] == null ? null : Route.fromJson(json["route"]),
        sender:
            json["sender"] == null ? null : Recipient.fromJson(json["sender"]),
        recipient: json["recipient"] == null
            ? null
            : Recipient.fromJson(json["recipient"]),
        paymentAmountInfo: json["paymentAmountInfo"],
        payment: json["payment"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "draft": draft,
        "isBulkShipment": isBulkShipment,
        "serviceTypeId": serviceTypeId,
        "freightTypeId": freightTypeId,
        "trackingNumber": trackingNumber,
        "totalWeight": totalWeight,
        "totalVWeight": totalVWeight,
        "totalChargeableWeight": totalChargeableWeight,
        "serviceType": serviceType?.toJson(),
        "freightType": freightType?.toJson(),
        "route": route?.toJson(),
        "sender": sender?.toJson(),
        "recipient": recipient?.toJson(),
        "paymentAmountInfo": paymentAmountInfo,
        "payment": payment,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Type {
  int? id;
  String? name;

  Type({
    this.id,
    this.name,
  });

  Type copyWith({
    int? id,
    String? name,
  }) =>
      Type(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Item {
  String? packageTypeName;
  String? itemTypeName;
  String? description;
  int? packageTypeId;
  int? itemTypeId;
  int? numberOfPieces;
  int? quantityPerPiece;
  int? totalQuantities;
  int? unitWeight;
  int? unitItemWidth;
  int? unitItemHeight;
  int? unitItemLength;
  double? unitItemVolumetricWeight;
  int? totalWeight;
  double? totalShipmentVolumetricWeight;
  int? totalValue;
  int? shipmentCharge;
  bool? isFragile;
  int? volumetricWeightUnitOfMeasureId;
  String? id;

  Item({
    this.packageTypeName,
    this.itemTypeName,
    this.description,
    this.packageTypeId,
    this.itemTypeId,
    this.numberOfPieces,
    this.quantityPerPiece,
    this.totalQuantities,
    this.unitWeight,
    this.unitItemWidth,
    this.unitItemHeight,
    this.unitItemLength,
    this.unitItemVolumetricWeight,
    this.totalWeight,
    this.totalShipmentVolumetricWeight,
    this.totalValue,
    this.shipmentCharge,
    this.isFragile,
    this.volumetricWeightUnitOfMeasureId,
    this.id,
  });

  Item copyWith({
    String? packageTypeName,
    String? itemTypeName,
    String? description,
    int? packageTypeId,
    int? itemTypeId,
    int? numberOfPieces,
    int? quantityPerPiece,
    int? totalQuantities,
    int? unitWeight,
    int? unitItemWidth,
    int? unitItemHeight,
    int? unitItemLength,
    double? unitItemVolumetricWeight,
    int? totalWeight,
    double? totalShipmentVolumetricWeight,
    int? totalValue,
    int? shipmentCharge,
    bool? isFragile,
    int? volumetricWeightUnitOfMeasureId,
    String? id,
  }) =>
      Item(
        packageTypeName: packageTypeName ?? this.packageTypeName,
        itemTypeName: itemTypeName ?? this.itemTypeName,
        description: description ?? this.description,
        packageTypeId: packageTypeId ?? this.packageTypeId,
        itemTypeId: itemTypeId ?? this.itemTypeId,
        numberOfPieces: numberOfPieces ?? this.numberOfPieces,
        quantityPerPiece: quantityPerPiece ?? this.quantityPerPiece,
        totalQuantities: totalQuantities ?? this.totalQuantities,
        unitWeight: unitWeight ?? this.unitWeight,
        unitItemWidth: unitItemWidth ?? this.unitItemWidth,
        unitItemHeight: unitItemHeight ?? this.unitItemHeight,
        unitItemLength: unitItemLength ?? this.unitItemLength,
        unitItemVolumetricWeight:
            unitItemVolumetricWeight ?? this.unitItemVolumetricWeight,
        totalWeight: totalWeight ?? this.totalWeight,
        totalShipmentVolumetricWeight:
            totalShipmentVolumetricWeight ?? this.totalShipmentVolumetricWeight,
        totalValue: totalValue ?? this.totalValue,
        shipmentCharge: shipmentCharge ?? this.shipmentCharge,
        isFragile: isFragile ?? this.isFragile,
        volumetricWeightUnitOfMeasureId: volumetricWeightUnitOfMeasureId ??
            this.volumetricWeightUnitOfMeasureId,
        id: id ?? this.id,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        packageTypeName: json["packageTypeName"],
        itemTypeName: json["itemTypeName"],
        description: json["description"],
        packageTypeId: json["packageTypeId"],
        itemTypeId: json["itemTypeId"],
        numberOfPieces: json["numberOfPieces"],
        quantityPerPiece: json["quantityPerPiece"],
        totalQuantities: json["totalQuantities"],
        unitWeight: json["unitWeight"],
        unitItemWidth: json["unitItemWidth"],
        unitItemHeight: json["unitItemHeight"],
        unitItemLength: json["unitItemLength"],
        unitItemVolumetricWeight: json["unitItemVolumetricWeight"]?.toDouble(),
        totalWeight: json["totalWeight"],
        totalShipmentVolumetricWeight:
            json["totalShipmentVolumetricWeight"]?.toDouble(),
        totalValue: json["totalValue"],
        shipmentCharge: json["shipmentCharge"],
        isFragile: json["isFragile"],
        volumetricWeightUnitOfMeasureId:
            json["volumetricWeightUnitOfMeasureId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "packageTypeName": packageTypeName,
        "itemTypeName": itemTypeName,
        "description": description,
        "packageTypeId": packageTypeId,
        "itemTypeId": itemTypeId,
        "numberOfPieces": numberOfPieces,
        "quantityPerPiece": quantityPerPiece,
        "totalQuantities": totalQuantities,
        "unitWeight": unitWeight,
        "unitItemWidth": unitItemWidth,
        "unitItemHeight": unitItemHeight,
        "unitItemLength": unitItemLength,
        "unitItemVolumetricWeight": unitItemVolumetricWeight,
        "totalWeight": totalWeight,
        "totalShipmentVolumetricWeight": totalShipmentVolumetricWeight,
        "totalValue": totalValue,
        "shipmentCharge": shipmentCharge,
        "isFragile": isFragile,
        "volumetricWeightUnitOfMeasureId": volumetricWeightUnitOfMeasureId,
        "id": id,
      };
}

class Recipient {
  String? companyName;
  String? firstName;
  String? lastName;
  bool? notifyReceiver;
  Address? address;

  Recipient({
    this.companyName,
    this.firstName,
    this.lastName,
    this.notifyReceiver,
    this.address,
  });

  Recipient copyWith({
    String? companyName,
    String? firstName,
    String? lastName,
    bool? notifyReceiver,
    Address? address,
  }) =>
      Recipient(
        companyName: companyName ?? this.companyName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        notifyReceiver: notifyReceiver ?? this.notifyReceiver,
        address: address ?? this.address,
      );

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
        companyName: json["companyName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        notifyReceiver: json["notifyReceiver"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "firstName": firstName,
        "lastName": lastName,
        "notifyReceiver": notifyReceiver,
        "address": address?.toJson(),
      };
}

class Address {
  String? countryName;
  String? cityName;
  String? countryCode;
  int? cityId;
  String? subcity;
  String? houseNumber;
  String? phoneNumber;
  String? email;
  String? id;

  Address({
    this.countryName,
    this.cityName,
    this.countryCode,
    this.cityId,
    this.subcity,
    this.houseNumber,
    this.phoneNumber,
    this.email,
    this.id,
  });

  Address copyWith({
    String? countryName,
    String? cityName,
    String? countryCode,
    int? cityId,
    String? subcity,
    String? houseNumber,
    String? phoneNumber,
    String? email,
    String? id,
  }) =>
      Address(
        countryName: countryName ?? this.countryName,
        cityName: cityName ?? this.cityName,
        countryCode: countryCode ?? this.countryCode,
        cityId: cityId ?? this.cityId,
        subcity: subcity ?? this.subcity,
        houseNumber: houseNumber ?? this.houseNumber,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        id: id ?? this.id,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        countryName: json["countryName"],
        cityName: json["cityName"],
        countryCode: json["countryCode"],
        cityId: json["cityId"],
        subcity: json["subcity"],
        houseNumber: json["houseNumber"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "countryName": countryName,
        "cityName": cityName,
        "countryCode": countryCode,
        "cityId": cityId,
        "subcity": subcity,
        "houseNumber": houseNumber,
        "phoneNumber": phoneNumber,
        "email": email,
        "id": id,
      };
}

class Route {
  String? originCountryName;
  String? originCityName;
  String? destinationCountryName;
  String? destinationCityName;
  String? orderId;
  int? serviceTypeId;
  String? originCountryCode;
  int? originBranchId;
  int? destinationBranchId;
  int? originCityId;
  String? destinationCountryCode;
  int? destinationCityId;
  int? freightTypeId;
  bool? isBulkShipment;

  Route({
    this.originCountryName,
    this.originCityName,
    this.destinationCountryName,
    this.destinationCityName,
    this.orderId,
    this.serviceTypeId,
    this.originCountryCode,
    this.originBranchId,
    this.destinationBranchId,
    this.originCityId,
    this.destinationCountryCode,
    this.destinationCityId,
    this.freightTypeId,
    this.isBulkShipment,
  });

  Route copyWith({
    String? originCountryName,
    String? originCityName,
    String? destinationCountryName,
    String? destinationCityName,
    String? orderId,
    int? serviceTypeId,
    String? originCountryCode,
    int? originBranchId,
    int? destinationBranchId,
    int? originCityId,
    String? destinationCountryCode,
    int? destinationCityId,
    int? freightTypeId,
    bool? isBulkShipment,
  }) =>
      Route(
        originCountryName: originCountryName ?? this.originCountryName,
        originCityName: originCityName ?? this.originCityName,
        destinationCountryName:
            destinationCountryName ?? this.destinationCountryName,
        destinationCityName: destinationCityName ?? this.destinationCityName,
        orderId: orderId ?? this.orderId,
        serviceTypeId: serviceTypeId ?? this.serviceTypeId,
        originCountryCode: originCountryCode ?? this.originCountryCode,
        originBranchId: originBranchId ?? this.originBranchId,
        destinationBranchId: destinationBranchId ?? this.destinationBranchId,
        originCityId: originCityId ?? this.originCityId,
        destinationCountryCode:
            destinationCountryCode ?? this.destinationCountryCode,
        destinationCityId: destinationCityId ?? this.destinationCityId,
        freightTypeId: freightTypeId ?? this.freightTypeId,
        isBulkShipment: isBulkShipment ?? this.isBulkShipment,
      );

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        originCountryName: json["originCountryName"],
        originCityName: json["originCityName"],
        destinationCountryName: json["destinationCountryName"],
        destinationCityName: json["destinationCityName"],
        orderId: json["orderId"],
        serviceTypeId: json["serviceTypeId"],
        originCountryCode: json["originCountryCode"],
        originBranchId: json["originBranchId"],
        destinationBranchId: json["destinationBranchId"],
        originCityId: json["originCityId"],
        destinationCountryCode: json["destinationCountryCode"],
        destinationCityId: json["destinationCityId"],
        freightTypeId: json["freightTypeId"],
        isBulkShipment: json["isBulkShipment"],
      );

  Map<String, dynamic> toJson() => {
        "originCountryName": originCountryName,
        "originCityName": originCityName,
        "destinationCountryName": destinationCountryName,
        "destinationCityName": destinationCityName,
        "orderId": orderId,
        "serviceTypeId": serviceTypeId,
        "originCountryCode": originCountryCode,
        "originBranchId": originBranchId,
        "destinationBranchId": destinationBranchId,
        "originCityId": originCityId,
        "destinationCountryCode": destinationCountryCode,
        "destinationCityId": destinationCityId,
        "freightTypeId": freightTypeId,
        "isBulkShipment": isBulkShipment,
      };
}
