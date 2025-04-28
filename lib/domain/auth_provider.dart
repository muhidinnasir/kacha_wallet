import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanza_express/data/models/create_receiver_shipment_info_model.dart';
import 'package:wanza_express/data/models/creating_shipment_sender_model.dart';
import 'package:wanza_express/data/models/currentuserbranchs_model.dart';
import 'package:wanza_express/data/models/destination_branch_model.dart';
import 'package:wanza_express/data/models/destination_city_model.dart';
import 'package:wanza_express/data/models/destination_country_model.dart';
import 'package:wanza_express/data/models/freight_types_model.dart';
import 'package:wanza_express/data/models/item_type_model.dart';
import 'package:wanza_express/data/models/origin_cities_model.dart';
import 'package:wanza_express/data/models/fright_type_model.dart';
import 'package:wanza_express/data/models/shipment_detail_model.dart';
import 'package:wanza_express/data/models/shipment_package_types_model.dart';
import '../data/models/countries_model.dart';
import '../data/models/shipment_initiate_model.dart';
import '../data/repositories/api_service.dart';

class AuthState {
  final bool isLoggedIn;
  final String? email;
  final String? error;
  final bool isShowPassword;

  AuthState({
    required this.isLoggedIn,
    this.email,
    this.error,
    this.isShowPassword = false,
  });
}

// create a country provider
final countriesProvider =
    StateNotifierProvider<CountriesNotifier, List<CountriesModel>>(
  (ref) => CountriesNotifier(ApiService()),
);

class CountriesNotifier extends StateNotifier<List<CountriesModel>> {
  final ApiService apiService;

  CountriesNotifier(this.apiService) : super([]);

  Future<void> fetchOriginCountries() async {
    try {
      final countries = await apiService.getCountries();
      state = countries;
    } catch (e) {
      // Handle error
      state = [];
    }
  }
}

// create a provider for origin cities
final originCitiesProvider =
    StateNotifierProvider<OriginCitiesNotifier, OriginCitiesModel>(
  (ref) => OriginCitiesNotifier(ApiService()),
);

class OriginCitiesNotifier extends StateNotifier<OriginCitiesModel> {
  final ApiService apiService;

  OriginCitiesNotifier(this.apiService) : super(OriginCitiesModel());

  Future<void> fetchOriginCities(String countryId) async {
    try {
      final cities =
          await apiService.getOriginCitiesBasedOnCountryCode(countryId);
      state = cities;
    } catch (e) {
      // Handle error
      state = OriginCitiesModel();
    }
  }
}

// create a provider for current user branchs
final currentUserBranchsProvider = StateNotifierProvider<
    CurrentUserBranchsNotifier, CurrentUserBranchesModel?>(
  (ref) => CurrentUserBranchsNotifier(ApiService()),
);

class CurrentUserBranchsNotifier
    extends StateNotifier<CurrentUserBranchesModel?> {
  final ApiService apiService;

  CurrentUserBranchsNotifier(this.apiService) : super(null) {
    fetchCurrentUserBranchs();
  }

  Future<void> fetchCurrentUserBranchs() async {
    try {
      final branchs = await apiService.getCurrentUserBranches();
      state = branchs;
    } catch (e, s) {
      // print the errors
      debugPrint('Error fetching the user branch => $e, $s');
      // Handle error
      state = null;
    }
  }
}

// create a provider for current user branchs based on branch id
final currentUserBranchsBasedOnBranchIdProvider = StateNotifierProvider<
    CurrentUserBranchsBasedOnBranchIdNotifier, List<CurrentUserBranchesModel>>(
  (ref) => CurrentUserBranchsBasedOnBranchIdNotifier(ApiService()),
);

class CurrentUserBranchsBasedOnBranchIdNotifier
    extends StateNotifier<List<CurrentUserBranchesModel>> {
  final ApiService apiService;

  CurrentUserBranchsBasedOnBranchIdNotifier(this.apiService) : super([]);

  Future<void> fetchCurrentUserBranchsBasedOnBranchId(String branchId) async {
    try {
      final branchs =
          await apiService.getCurrentUserBranchesBasedOnBranchId(branchId);
      state = branchs;
    } catch (e) {
      // Handle error
      state = [];
    }
  }
}

// create a provider for current user branchs based on branch id
final destinationCountryBasedOnOriginCityIdProvider =
    StateNotifierProvider<DestinationCountryNotifier, CountryModel>(
  (ref) => DestinationCountryNotifier(ApiService()),
);

class DestinationCountryNotifier extends StateNotifier<CountryModel> {
  final ApiService apiService;

  DestinationCountryNotifier(this.apiService) : super(CountryModel());

  Future<void> fetchDestinationCountryBasedOnOriginCityId(
      String originCityId) async {
    try {
      final branchs = await apiService
          .getDestinationCountryBasedOnOriginCityId(originCityId);
      state = branchs;
    } catch (e, s) {
      debugPrint('Error while loading destination country ==> $e, $s');
      // Handle error
      state = CountryModel();
    }
  }
}

// create a provider for destination City
final destinationCityProvider =
    StateNotifierProvider<DestinationCityNotifier, List<DestinationCityModel>>(
  (ref) => DestinationCityNotifier(ApiService()),
);

class DestinationCityNotifier
    extends StateNotifier<List<DestinationCityModel>> {
  final ApiService apiService;

  DestinationCityNotifier(this.apiService) : super([]);

  Future<void> fetchDestinationCity(
    String originCityId,
    String destinationCountryCode,
  ) async {
    try {
      final branchs = await apiService.getDestinationCity(
        originCityId,
        destinationCountryCode,
      );
      state = branchs;
    } catch (e, s) {
      debugPrint('Error while loading destination country ==> $e, $s');
      // Handle error
      state = [];
    }
  }
}

// create a provider for destination City
final destinationBranchProvider = StateNotifierProvider<
    DestinationBranchNotifier, List<DestinationBranchModel>>(
  (ref) => DestinationBranchNotifier(ApiService()),
);

class DestinationBranchNotifier
    extends StateNotifier<List<DestinationBranchModel>> {
  final ApiService apiService;

  DestinationBranchNotifier(this.apiService) : super([]);

  Future<void> fetchDestinationBranch(
    String originBranchId,
    String destinationCountryCode,
  ) async {
    try {
      final branchs = await apiService.searchBranches(
        destinationCityId: originBranchId,
        destinationCountryCode: destinationCountryCode,
      );
      state = branchs;
    } catch (e, s) {
      debugPrint('Error while loading destination country ==> $e, $s');
      // Handle error
      state = [];
    }
  }
}

// create a provider for destination City
final freightTypeProvider =
    StateNotifierProvider<FreightTypeNotifier, List<FreightTypeModel>>(
  (ref) => FreightTypeNotifier(ApiService()),
);

class FreightTypeNotifier extends StateNotifier<List<FreightTypeModel>> {
  final ApiService apiService;

  FreightTypeNotifier(this.apiService) : super([]);

  Future<void> fetchFreightTypes(
    String originBranchId,
    String destinationBranchId,
  ) async {
    try {
      final branchs = await apiService.getfreightType(
        originBranchId,
        destinationBranchId,
      );
      state = branchs;
    } catch (e, s) {
      debugPrint('Error while loading destination country ==> $e, $s');
      // Handle error
      state = [];
    }
  }
}

// create a provider for destination City
final freightTypesProvider =
    StateNotifierProvider<FreightTypesNotifier, List<FreightTypesModel>>(
  (ref) => FreightTypesNotifier(ApiService()),
);

class FreightTypesNotifier extends StateNotifier<List<FreightTypesModel>> {
  final ApiService apiService;

  FreightTypesNotifier(this.apiService) : super([]);

  Future<void> fetchFreightTypes() async {
    try {
      final branchs = await apiService.getfreightTypes();
      state = branchs;
    } catch (e, s) {
      debugPrint('Error while loading destination country ==> $e, $s');
      // Handle error
      state = [];
    }
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService apiService;

  AuthNotifier(this.apiService) : super(AuthState(isLoggedIn: false));

  Future<void> login(String email, String password) async {
    try {
      // await apiService.login(email, password);
      state = AuthState(isLoggedIn: true, email: email);
    } catch (e) {
      state = AuthState(isLoggedIn: false, error: e.toString());
    }
  }

  void changePasswordVisibility(value) {
    state = AuthState(isLoggedIn: false, isShowPassword: value);
  }

  void logout() {
    state = AuthState(isLoggedIn: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ApiService()),
);

// create a provider for Item types
final itemTypesProvider =
    StateNotifierProvider<ItemTypesNotifier, List<ItemTypesModel>>(
  (ref) => ItemTypesNotifier(ApiService()),
);

class ItemTypesNotifier extends StateNotifier<List<ItemTypesModel>> {
  final ApiService apiService;

  ItemTypesNotifier(this.apiService) : super([]);

  Future<void> fetchItemTypes() async {
    try {
      final itemTypes = await apiService.getItemTypes();
      state = itemTypes;
    } catch (e) {
      // Handle error
      state = [];
    }
  }
}

// create a provider for Item types
final packageTypeProvider =
    StateNotifierProvider<PackageTypeNotifier, List<ShipmentPackageTypesModel>>(
  (ref) => PackageTypeNotifier(ApiService()),
);

class PackageTypeNotifier
    extends StateNotifier<List<ShipmentPackageTypesModel>> {
  final ApiService apiService;

  PackageTypeNotifier(this.apiService) : super([]);

  Future<void> fetchpackageTypes() async {
    try {
      final packageTypes = await apiService.getpackageTypes();
      state = packageTypes;
    } catch (e) {
      // Handle error
      state = [];
    }
  }
}

final sharedShipmentStateProvider =
    StateNotifierProvider<SharedShipmentStateNotifier, ShipmentDetailModel?>(
  (ref) => SharedShipmentStateNotifier(ApiService()),
);

class SharedShipmentStateNotifier extends StateNotifier<ShipmentDetailModel?> {
  final ApiService apiService;
  SharedShipmentStateNotifier(this.apiService) : super(null);

  Future<void> initiateShipmentDetails(
      ShipmentInitiateModel shipmentInitialmodel) async {
    try {
      final shipmentDetails =
          await apiService.initiateShipment(shipmentInitialmodel);
      if (shipmentDetails != null && shipmentDetails.id != null) {
        debugPrint(
            'shipmentDetails id form  shipmentDetails not null==> ${shipmentDetails.id}');
        await apiService.shipmentDetail(shipmentDetails.id!).then((value) {
          state = value;
        });
      } else {
        debugPrint('shipmentDetails id form null ==> ${shipmentDetails?.id}');
        state = shipmentDetails;
      }
    } catch (e, s) {
      debugPrint('Error while loading shipment details ==> $e, $s');
      state = null;
    }
  }

  Future<void> updateReceiverDetails(
      CreateReceiverShipmentDetailModel receiverDetails) async {
    try {
      final shipmentDetails =
          await apiService.creteReceiverShipmentDetail(receiverDetails);
      if (shipmentDetails != null) {
        state = shipmentDetails.copyWith(
          recipient: shipmentDetails.recipient,
        );
      } else {
        state = shipmentDetails;
      }
    } catch (e) {
      debugPrint('Error while updating receiver details ==> $e');
      state = null;
    }
  }

  Future<void> updateSenderDetails(
      SenderShipmentDetailModel senderDetails) async {
    try {
      await Future.wait([
        apiService.creteShipmentSenderDetail(senderDetails),
      ]).then((value) {
        state = value.first?.copyWith(
          sender: value.first?.sender,
        );
      });
    } catch (e, s) {
      debugPrint('Error while updating sender details ==> $e $s');
      state = null;
    }
  }
}
