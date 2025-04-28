import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanza_express/data/models/shipment_initiate_model.dart';
import 'package:wanza_express/presentation/screens/shipmentDetailFormScreen/shipment_detail_form_screen.dart';
import 'package:wanza_express/presentation/widgets/custom_image_view.dart';
import '../../../../data/models/currentuserbranchs_model.dart';
import '../../../../domain/auth_provider.dart';
import '../../../widgets/custom_DropdownFormField.dart';

class ShipmentDirectionInfoWidget extends ConsumerStatefulWidget {
  final ShipmentInitiateModel shipmentInitiateModel;
  const ShipmentDirectionInfoWidget({
    super.key,
    required this.shipmentInitiateModel,
  });

  @override
  ConsumerState<ShipmentDirectionInfoWidget> createState() =>
      _FromAndToWidgetState();
}

class _FromAndToWidgetState extends ConsumerState<ShipmentDirectionInfoWidget> {
  String? _selectedToCity;
  String? _selectedFreightType;
  String selectedCountry = "Ethiopia";
  String selectedCountryCode = "ET";
  String selectedDestinationCountry = "";
  String selectedDestinationCountryCode = "";
  String? _selectedBranch;
  String? originCityId;

  bool isDomestic = true;
  bool isBulkShipment = false;
  bool isEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initializeCountriesAndCities() async {
    await Future.wait([
      ref.read(currentUserBranchsProvider.notifier).fetchCurrentUserBranchs(),
    ]).then((_) async {
      final currentUserBranchState = ref.watch(currentUserBranchsProvider);
      if (currentUserBranchState == null) {
        debugPrint("No current user branches available");
        return;
      }
      setState(() {
        selectedCountry = currentUserBranchState.country ?? "Ethiopia";
        selectedCountryCode = currentUserBranchState.countryCode ?? "ET";
        selectedDestinationCountry = currentUserBranchState.name ?? "";
        originCityId = currentUserBranchState.cityId.toString();
      });
      if (originCityId != null) {
        widget.shipmentInitiateModel.originBranchId =
            int.parse(currentUserBranchState.id.toString());
        widget.shipmentInitiateModel.originCityId =
            int.parse(originCityId ?? '1');
        widget.shipmentInitiateModel.originCountryCode = selectedCountryCode;
        widget.shipmentInitiateModel.destinationCountryCode =
            selectedCountryCode;

        // Fetch destination country and city immediately
        await Future.wait([
          ref
              .read(destinationCountryBasedOnOriginCityIdProvider.notifier)
              .fetchDestinationCountryBasedOnOriginCityId(originCityId!),
          ref
              .read(destinationCityProvider.notifier)
              .fetchDestinationCity(originCityId!, selectedCountryCode),
        ]);

        // Fetch destination branches after fetching destination cities
        ref.read(destinationBranchProvider.notifier).fetchDestinationBranch(
              originCityId!,
              selectedCountryCode,
            );
      }
    }).catchError((error) {
      debugPrint("Error fetching countries or cities: $error");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeCountriesAndCities();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUserBranchsState = ref.watch(currentUserBranchsProvider);
    final destinationCountryBasedOnOriginCityIdState =
        ref.watch(destinationCountryBasedOnOriginCityIdProvider);
    final destinationCityState = ref.watch(destinationCityProvider);
    final destinationBranchState = ref.watch(destinationBranchProvider);
    final freightTypeState = ref.watch(freightTypeProvider);
    return Form(
      key: fromToFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShipmentTypeSelector(theme),
            const SizedBox(height: 20),
            Text(
              "From",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffB6B6B6),
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Origin Country',
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 6),
            _buildCountryDropdown(
              countriesState: currentUserBranchsState,
              onChanged: (v) {},
            ),
            const SizedBox(height: 30),

            _buildDropdownSection(
              title: "Origin City",
              selectedValue: currentUserBranchsState?.city,
              items: currentUserBranchsState != null
                  ? [currentUserBranchsState.city!]
                  : [],
              onChanged: (v) {}, // Disable selection
            ),
            const SizedBox(height: 30),
            _buildDropdownSection(
              title: "Origin Branch",
              selectedValue: currentUserBranchsState?.name,
              items: currentUserBranchsState != null
                  ? [currentUserBranchsState.name!]
                  : [],
              onChanged: (v) {
                setState(() {
                  int originBranchId =
                      int.parse(currentUserBranchsState?.id.toString() ?? '');
                  widget.shipmentInitiateModel.originBranchId = originBranchId;
                });
              }, // Disable selection
            ),
            const SizedBox(height: 30),
            Text(
              "To",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffB6B6B6),
                  ),
            ),
            const SizedBox(height: 10),
            if (!isDomestic) ...[
              _buildDropdownSection(
                title: "Destination Country",
                selectedValue: selectedDestinationCountry,
                items: destinationCountryBasedOnOriginCityIdState.name == null
                    ? []
                    : [destinationCountryBasedOnOriginCityIdState.name ?? ''],
                onChanged: (value) => setState(() {
                  _selectedToCity = null;
                  selectedDestinationCountry = value!;
                  if (currentUserBranchsState == null) {
                    return;
                  } else {
                    selectedDestinationCountryCode =
                        currentUserBranchsState.countryCode.toString();
                    widget.shipmentInitiateModel.destinationCountryCode =
                        selectedDestinationCountryCode;
                    ref
                        .read(destinationCityProvider.notifier)
                        .fetchDestinationCity(
                          currentUserBranchsState.cityId.toString(),
                          selectedDestinationCountryCode,
                        );
                  }
                }),
                isEnabled: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a destination country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
            ],
            _buildDropdownSection(
              title: "Destination City",
              selectedValue: _selectedToCity,
              items: destinationCityState
                  .map((e) => e.name)
                  .whereType<String>()
                  .toList(),
              onChanged: (value) => setState(() {
                _selectedToCity = value;
                final destinationCityId = destinationCityState
                    .firstWhere((element) => element.name == _selectedToCity)
                    .id;
                if (destinationCityId != null) {
                  widget.shipmentInitiateModel.destinationCityId =
                      destinationCityId; // Update the shared instance
                  ref
                      .read(destinationBranchProvider.notifier)
                      .fetchDestinationBranch(
                        destinationCityId.toString(),
                        destinationCountryBasedOnOriginCityIdState.countryCode
                            .toString(),
                      );
                }
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a destination city';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            _buildDropdownSection(
              title: "Destination Branch",
              selectedValue: _selectedBranch,
              items: destinationBranchState
                  .map((e) => e.name)
                  .whereType<String>()
                  .toList(),
              onChanged: (value) => setState(() {
                _selectedBranch = value;
                if (value == null || destinationBranchState.isEmpty) {
                  return;
                }
                final destinationBranchId = destinationBranchState
                        .firstWhere((element) => element.name == value)
                        .id ??
                    '';
                if (currentUserBranchsState == null) {
                  return;
                } else {
                  widget.shipmentInitiateModel.destinationBranchId = int.parse(
                      destinationBranchId); // Update the shared instance
                  ref.read(freightTypeProvider.notifier).fetchFreightTypes(
                        currentUserBranchsState.id.toString(),
                        destinationBranchId,
                      );
                }
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a destination branch';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Text(
              "Freight Type",
              style: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 53,
              child: CustomDropdownFormField<String>(
                value: _selectedFreightType,
                items: freightTypeState
                    .map((item) => DropdownMenuItem(
                          value: item.freightTypeName,
                          child: Text(item.freightTypeName ?? ""),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _selectedFreightType = value;
                  final freightTypeId = freightTypeState
                      .firstWhere((element) => element.freightTypeName == value)
                      .freightTypeId;
                  if (freightTypeId != null) {
                    widget.shipmentInitiateModel.freightTypeId = freightTypeId;
                  }
                }),
                hint: Text(
                  "Select Freight Type",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 13),
                ),
                isExpanded: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a freight type';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            // Bulk Shipment? switch widget
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Bulk Shipment?",
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  // set the value to true or false based on your logic
                  value: isBulkShipment,
                  onChanged: (value) {
                    setState(() {
                      isBulkShipment = value;
                      // Update the shipment model with the new value
                      widget.shipmentInitiateModel.isBulkShipment =
                          isBulkShipment;
                    });
                  },
                  activeColor: theme.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShipmentTypeSelector(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildSelectableContainer(
            label: "Domestic",
            isSelected: isDomestic,
            onTap: () => setState(() {
              isDomestic = true;
              widget.shipmentInitiateModel.serviceTypeId = 1;
              _initializeCountriesAndCities();
            }),
            theme: theme,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildSelectableContainer(
            label: "International",
            isSelected: !isDomestic,
            onTap: () => setState(() {
              isDomestic = false;
              widget.shipmentInitiateModel.serviceTypeId = 2;
              _initializeCountriesAndCities();
            }),
            theme: theme,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectableContainer({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : const Color(0xffFFFEE6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffE7E7E7), width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              color: const Color(0xff616161),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountryDropdown({
    required CurrentUserBranchesModel? countriesState,
    required ValueChanged<String?> onChanged,
  }) {
    if (countriesState == null) {
      return const Text("No countries available");
    }

    // Ensure unique items in the dropdown
    final uniqueCountries = countriesState;

    return DropdownButtonFormField<String>(
      value: countriesState.countryCode == null ? null : selectedCountry,
      isExpanded: true,
      items: uniqueCountries.countryCode != null
          ? [
              DropdownMenuItem<String>(
                value: uniqueCountries.country,
                child: Row(
                  children: [
                    if (uniqueCountries.countryCode != null) ...[
                      CustomImageView(
                        imagePath:
                            "https://flagcdn.com/w40/${uniqueCountries.countryCode!.toLowerCase()}.png",
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                        radius: BorderRadius.circular(4),
                      ),
                    ],
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        uniqueCountries.country ?? '',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ]
          : [],
      onChanged: null,
      decoration: _buildInputDecoration(),
    );
  }

  Widget _buildDropdownSection(
      {required String title,
      String? selectedValue,
      required List<String> items,
      ValueChanged<String?>? onChanged,
      bool isEnabled = true,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 53,
          child: CustomDropdownFormField<String>(
            value: selectedValue,

            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: isEnabled
                ? onChanged ?? (_) {}
                : (_) {}, // Provide a default no-op function when disabled
            hint: Text(
              isEnabled ? "Select $title" : title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 14, color: Colors.grey),
            ),
            isExpanded: isEnabled,
            validator: validator,
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xffE7E7E7),
      contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
    );
  }
}
