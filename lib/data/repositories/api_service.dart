import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wanza_express/core/util/flutter_scure_storege_utils.dart';
import 'package:wanza_express/data/models/countries_model.dart';
import 'package:wanza_express/data/models/creating_shipment_sender_model.dart';
import 'package:wanza_express/data/models/destination_country_model.dart';
import 'package:wanza_express/data/models/item_type_model.dart';
import 'package:wanza_express/data/models/origin_cities_model.dart';
import 'package:wanza_express/data/models/fright_type_model.dart';
import 'package:http/http.dart' as http;
import 'package:wanza_express/data/models/shipment_detail_model.dart';
import 'package:wanza_express/data/models/shipment_package_types_model.dart';

import '../../core/constants.dart';
import '../models/create_receiver_shipment_info_model.dart';
import '../models/currentuserbranchs_model.dart';
import '../models/destination_branch_model.dart';
import '../models/destination_city_model.dart';
import '../models/freight_types_model.dart';
import '../models/shipment_initiate_model.dart';

const FlutterAppAuth appAuth = FlutterAppAuth();
final String clientId = dotenv.env['CLIENT_ID'] ?? '';
final String redirectUrl = dotenv.env['REDIRECT_URI'] ?? '';
final String discoveryurl = dotenv.env['DISCOVERY_URL'] ?? '';
final String issuer = dotenv.env['ISSUER'] ?? '';
const List<String> scopes = ['openid', 'profile', 'email', 'offline_access'];

class ApiService {
  // get customer company name list from api using http
  Future<List<String>> getCustomerCompanyNameList() async {
    final headers = <String, String>{
      'Authorization': 'Bearer YOUR_SECRET_TOKEN',
    };
    final response = await http
        .get(Uri.parse('$baseURL/api/Branches/current-user'), headers: headers);
    if (response.statusCode == 200) {
      final List<String> companyNames =
          List<String>.from(json.decode(response.body));
      return companyNames;
    } else {
      throw Exception('Failed to load company names');
    }
  }

  // get countries list from api using http
  Future<List<CountriesModel>> getCountries() async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$baseURL/master-data/api/Countries'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final List<dynamic> countriesJson = json.decode(response.body);
        if (countriesJson.isEmpty) {
          throw Exception('No countries found');
        }
        // Assuming you want the first country in the list
        final List<CountriesModel> countriesList = countriesJson
            .map((country) => CountriesModel.fromJson(country))
            .toList();
        return countriesList;
      } else if (response.statusCode == 401) {
        // refresh the token and try again
        return await ApiService().refreshToken().then((_) {
          return getCountries();
        }).catchError((error) {
          throw Exception('Failed to fetch countries: $error');
        });
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e, s) {
      // Handle any exceptions that may occur during the process
      throw Exception('Failed to fetch countries: $e $s');
    }
  }

  // get origin cities based on country code from api using http
  Future<OriginCitiesModel> getOriginCitiesBasedOnCountryCode(
      String countryCode) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$baseURL/master-data/api/Routes/$countryCode/origin-cities'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final List<dynamic> routesJson = json.decode(response.body);
        if (routesJson.isEmpty) {
          throw Exception('No routes found for the country code: $countryCode');
        }
        // Assuming you want the first route in the list
        final OriginCitiesModel routesList =
            OriginCitiesModel.fromJson(routesJson[0]);
        return routesList;
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        return await ApiService().refreshToken().then((_) {
          return getOriginCitiesBasedOnCountryCode(countryCode);
        }).catchError((error) {
          throw Exception('Failed to fetch countries: $error');
        });
      } else {
        throw Exception('Failed to load routes for country code: $countryCode');
      }
    } catch (e, s) {
      // Handle any exceptions that may occur during the process
      throw Exception('Failed to fetch routes: $e $s');
    }
  }

  Future<List<DestinationBranchModel>> searchBranches({
    required String destinationCountryCode,
    required String destinationCityId,
  }) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');

      const String url = '$baseURL/master-data/api/branches/search';
      debugPrint('URL: $destinationCityId');
      debugPrint('Destination Country Code: $destinationCountryCode');

      final headers = {
        'authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        'x-filter': json.encode({
          "SearchKeyWord": '',
          "Filters": {
            "City": destinationCityId,
          }
        }),
      };
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        // Parse or return the response
        final List<dynamic> branchesJson = json.decode(response.body);
        if (branchesJson.isEmpty) {
          throw Exception('No branches found for the given criteria');
        }
        debugPrint('search Branches found: $branchesJson');
        return branchesJson
            .map((branch) => DestinationBranchModel.fromJson(branch))
            .toList();
      } else if (response.statusCode == 401) {
        // Handle token refresh or re-authentication
        throw Exception('Unauthorized: Token may be expired');
      } else {
        throw Exception(
            'Failed to search branches. Status code: ${response.statusCode}');
      }
    } catch (e, s) {
      debugPrint('Error occurred while searching branches: $e $s');
      throw Exception('Error occurred while searching branches: $e');
    }
  }

  // get current user branches from api using http
  Future<CurrentUserBranchesModel> getCurrentUserBranches() async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$baseURL/master-data/api/branches/current-user'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);

        debugPrint('Current User Branches: $responseBody');
        final branch = CurrentUserBranchesModel.fromJson(responseBody);
        return branch;
      } else if (response.statusCode == 401) {
        debugPrint('Token expired, refreshing...');
        return await ApiService().refreshToken().then((_) async {
          return await getCurrentUserBranches();
        }).catchError((error) {
          loginWithKeycloak()
              .then((value) async => await getCurrentUserBranches());

          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to load branches for the current user');
      }
    } catch (e, s) {
      debugPrint('Failed to fetch branches: $e $s');
      throw Exception('Failed to fetch branches: $e $s');
    }
  }

  Future<List<CurrentUserBranchesModel>> getCurrentUserBranchesBasedOnBranchId(
      String branchId) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$baseURL/master-data/api/Branches/$branchId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);

        // Check if the response is a map or a list
        if (responseBody is Map<String, dynamic>) {
          // If it's a single branch, wrap it in a list
          final branch = CurrentUserBranchesModel.fromJson(responseBody);
          return [branch];
        } else if (responseBody is List<dynamic>) {
          // If it's a list of branches, map them to the model
          return responseBody
              .map((branch) => CurrentUserBranchesModel.fromJson(branch))
              .toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await getCurrentUserBranchesBasedOnBranchId(branchId);
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to load branches for the current user');
      }
    } catch (e, s) {
      throw Exception('Failed to fetch branches: $e $s');
    }
  }

  // distnation country
  Future<CountryModel> getDestinationCountryBasedOnOriginCityId(
      String originCityId) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse(
            '$baseURL/master-data/api/Routes/$originCityId/destination-country'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);
        if (responseBody is List<dynamic> && responseBody.isNotEmpty) {
          final branch = CountryModel.fromJson(responseBody[0]);
          return branch;
        } else if (responseBody is Map<String, dynamic>) {
          final branch = CountryModel.fromJson(responseBody);
          return branch;
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await getDestinationCountryBasedOnOriginCityId(originCityId);
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to load branches for the current user');
      }
    } catch (e, s) {
      throw Exception('Failed to fetch branches: $e $s');
    }
  }

  // distnation city
  Future<List<DestinationCityModel>> getDestinationCity(
    String originCityId,
    String destinationCountryCode,
  ) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse(
            '$baseURL/master-data/api/Routes/$originCityId/$destinationCountryCode/destination-cities'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);
        debugPrint('Destination City: $responseBody');
        if (responseBody is List<dynamic> && responseBody.isNotEmpty) {
          // return all the destination cities
          final branch = responseBody
              .map((branch) => DestinationCityModel.fromJson(branch))
              .toList();
          return branch;
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await getDestinationCity(originCityId, destinationCountryCode);
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to load branches for the current user');
      }
    } catch (e, s) {
      throw Exception('Failed to fetch branches: $e $s');
    }
  }

  // distnation city
  Future<List<FreightTypeModel>> getfreightType(
    String originBranchId,
    String destinationBranchId,
  ) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse(
            '$baseURL/master-data/api/Routes/$originBranchId/$destinationBranchId/applicable-freight-types'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);
        debugPrint('Freight Type: $responseBody');
        // all the freight types
        if (responseBody is List<dynamic> && responseBody.isNotEmpty) {
          final freightType = responseBody
              .map((freightType) => FreightTypeModel.fromJson(freightType))
              .toList();
          return freightType;
        } else if (responseBody is Map<String, dynamic>) {
          final freightType = FreightTypeModel.fromJson(responseBody);
          return [freightType];
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await getfreightType(originBranchId, destinationBranchId);
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to load branches for the current user');
      }
    } catch (e, s) {
      throw Exception('Failed to fetch branches: $e $s');
    }
  }

  // distnation city
  Future<List<FreightTypesModel>> getfreightTypes() async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$baseURL/master-data/api/FreightTypes'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);
        // all the freight types
        if (responseBody is List<dynamic> && responseBody.isNotEmpty) {
          final freightType = responseBody
              .map((freightType) => FreightTypesModel.fromJson(freightType))
              .toList();
          return freightType;
        } else if (responseBody is Map<String, dynamic>) {
          final freightType = FreightTypesModel.fromJson(responseBody);
          return [freightType];
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await getfreightTypes();
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to load branches for the current user');
      }
    } catch (e, s) {
      throw Exception('Failed to fetch branches: $e $s');
    }
  }

  // distnation city
  Future<List<ItemTypesModel>> getItemTypes() async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$baseURL/master-data/api/ItemTypes'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);
        // all the freight types
        if (responseBody is List<dynamic> && responseBody.isNotEmpty) {
          final freightType = responseBody
              .map((freightType) => ItemTypesModel.fromJson(freightType))
              .toList();
          return freightType;
        } else if (responseBody is Map<String, dynamic>) {
          final freightType = ItemTypesModel.fromJson(responseBody);
          return [freightType];
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await getItemTypes();
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to load branches for the current user');
      }
    } catch (e, s) {
      throw Exception('Failed to fetch branches: $e $s');
    }
  }

  // distnation city
  Future<List<ShipmentPackageTypesModel>> getpackageTypes() async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$baseURL/master-data/api/packagetypes'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);
        // all the freight types
        if (responseBody is List<dynamic> && responseBody.isNotEmpty) {
          final freightType = responseBody
              .map((freightType) =>
                  ShipmentPackageTypesModel.fromJson(freightType))
              .toList();
          return freightType;
        } else if (responseBody is Map<String, dynamic>) {
          final freightType = ShipmentPackageTypesModel.fromJson(responseBody);
          return [freightType];
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await getpackageTypes();
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to load branches for the current user');
      }
    } catch (e, s) {
      throw Exception('Failed to fetch branches: $e $s');
    }
  }

  // distnation city
  Future<ShipmentDetailModel?> initiateShipment(
    ShipmentInitiateModel shipmentInitiateModel,
  ) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');

      // print the shipment
      debugPrint("shipment data ${shipmentInitiateModel.toJson()}");
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        Uri.parse('$baseURL/shipment/api/shipment/initiate'),
        headers: headers,
        body: shipmentInitiateModelToJson(shipmentInitiateModel),
      );
      if (response.statusCode == 201) {
        final dynamic responseBody = json.decode(response.body);
        final shipmentDetails = ShipmentDetailModel.fromJson(responseBody);
        return shipmentDetails;
      } else if (response.statusCode == 401) {
        return await Future.wait([
          ApiService().refreshToken(),
        ]).then((_) async {
          await initiateShipment(shipmentInitiateModel);
        }).onError((error, stackTrace) =>
            throw Exception('Failed to fetch branches: $error $stackTrace'));
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception(
            'Failed to load initiate shipment for the current user');
      }
    } catch (e, s) {
      debugPrint('Error occurred while initiating shipment: $e $s');
      throw Exception('Error occurred while initiating shipment: $e $s');
    }
  }

  // distnation city
  Future<ShipmentDetailModel?> shipmentDetail(String orderId) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$baseURL/shipment/api/shipment/$orderId/details'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);
        final shipmentDetails = ShipmentDetailModel.fromJson(responseBody);
        debugPrint('Shipment Details: $responseBody');
        return shipmentDetails;
      } else if (response.statusCode == 401) {
        return await Future.wait([
          ApiService().refreshToken(),
        ]).then((_) async {
          await shipmentDetail(orderId);
        }).onError((error, stackTrace) =>
            throw Exception('Failed to fetch branches: $error $stackTrace'));
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception(
            'Failed to load initiate shipment for the current user');
      }
    } catch (e, s) {
      debugPrint('Error occurred while initiating shipment: $e $s');
      throw Exception('Error occurred while initiating shipment: $e $s');
    }
  }

  // distnation city
  Future<ShipmentDetailModel?> creteShipmentSenderDetail(
    SenderShipmentDetailModel shipmentInitiateModel,
  ) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');
      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.put(
        Uri.parse(
            '$baseURL/shipment/api/Shipment/${shipmentInitiateModel.orderId}/sender'),
        headers: headers,
        body: senderShipmentDetailModelToJson(shipmentInitiateModel),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);
        // print the response body
        debugPrint('Response Body sender: $responseBody');
        final shipmentId = shipmentInitiateModel.orderId;
        final shipmentDetailResponse = await shipmentDetail(shipmentId!);
        return shipmentDetailResponse;
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await creteShipmentSenderDetail(shipmentInitiateModel);
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body sender: ${response.body}');
        throw Exception(
            'Failed to load initiate shipment for the current user');
      }
    } catch (e, s) {
      debugPrint('Error occurred while initiating shipment: $e $s');
      throw Exception('Error occurred while initiating shipment: $e $s');
    }
  }

  // distnation city
  Future<ShipmentDetailModel?> creteReceiverShipmentDetail(
    CreateReceiverShipmentDetailModel shipmentInitiateModel,
  ) async {
    try {
      final accessToken =
          await FlutterSecureStorageUtils.getValue('access_token');

      debugPrint(
          "shipmentInitiateModel orderId ${shipmentInitiateModel.orderId}");
      debugPrint(
          "shipmentInitiateModel companyName ${shipmentInitiateModel.companyName}");
      debugPrint(
          "shipmentInitiateModel firstName ${shipmentInitiateModel.firstName}");
      debugPrint(
          "shipmentInitiateModel lastName ${shipmentInitiateModel.lastName}");
      debugPrint(
          "shipmentInitiateModel countryCode ${shipmentInitiateModel.countryCode}");
      debugPrint(
          "shipmentInitiateModel cityId ${shipmentInitiateModel.cityId}");

      final headers = <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final response = await http.put(
        Uri.parse(
            '$baseURL/shipment/api/shipment/${shipmentInitiateModel.orderId}/recipient'),
        headers: headers,
        body: createReceiverShipmentDetailModelToJson(shipmentInitiateModel),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseBody = json.decode(response.body);
        debugPrint('Response Body receiver: $responseBody');
        final shipmentId = shipmentInitiateModel.orderId;
        final shipmentDetailResponse = await shipmentDetail(shipmentId!);
        return shipmentDetailResponse;
      } else if (response.statusCode == 401) {
        return await ApiService().refreshToken().then((_) async {
          return await creteReceiverShipmentDetail(shipmentInitiateModel);
        }).catchError((error) {
          throw Exception('Failed to fetch branches: $error');
        });
      } else {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception(
            'Failed to load initiate shipment for the current user');
      }
    } catch (e, s) {
      debugPrint('Error occurred while initiating shipment: $e $s');
      throw Exception('Error occurred while initiating shipment: $e $s');
    }
  }

  // login with keycloak
  Future<bool> loginWithKeycloak() async {
    try {
      final result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          issuer: issuer,
          scopes: scopes,
          discoveryUrl: discoveryurl,
          promptValues: ['login'],
        ),
      );
      final idToken = result.idToken;
      final accessToken = result.accessToken;
      // Decode the ID token
      Map<String, dynamic> decodedIdToken = {};
      if (idToken != null) {
        decodedIdToken = JwtDecoder.decode(idToken);
        // Save the ID token securely
        await FlutterSecureStorageUtils.saveValue('id_token', idToken);
      }
      if (accessToken != null) {
        await FlutterSecureStorageUtils.saveValue('access_token', accessToken);
      }
      // Extract branch ID from decoded ID token (if available)
      final branchId = decodedIdToken['branch'];
      if (branchId != null) {
        await FlutterSecureStorageUtils.saveValue('branch_id', branchId);
      }
      return true; // Login successful
    } catch (e, s) {
      // Handle any exceptions that may occur during the login process
      debugPrint('Login error: $e, $s');
      return false; // Login failed
    }
  }

  /// Logs the user out.
  Future<void> logout() async {
    try {
      final idToken = await FlutterSecureStorageUtils.getValue('id_token');
      await appAuth.endSession(EndSessionRequest(
        idTokenHint: idToken,
        discoveryUrl: discoveryurl,
        postLogoutRedirectUrl: redirectUrl,
      ));
    } catch (error) {
      throw Exception('Field to Logout');
    }
  }

  // Check if the access token is expired
  static Future<bool> isAccessTokenExpired() async {
    final accessToken =
        await FlutterSecureStorageUtils.getValue('access_token');
    if (accessToken != null) {
      return JwtDecoder.isExpired(accessToken);
    }
    return true; // Token is not available or expired
  }

  // separete function to refresh the token
  Future<void> refreshToken() async {
    try {
      final result = await appAuth.token(TokenRequest(
        clientId,
        redirectUrl,
        issuer: issuer,
        scopes: scopes,
        refreshToken: await FlutterSecureStorageUtils.getValue('refresh_token'),
      ));
      // Save the new tokens securely
      await FlutterSecureStorageUtils.saveValue(
          'access_token', result.accessToken ?? '');
      await FlutterSecureStorageUtils.saveValue(
          'refresh_token', result.refreshToken ?? '');
    } catch (e) {
      throw Exception('Failed to refresh access token: $e');
    }
  }
}
