import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanza_express/domain/auth_provider.dart';
import '../../../widgets/custom_DropdownFormField.dart';
import '../../../widgets/custom_text_form_field.dart';

class ItemsInformationScreen extends ConsumerStatefulWidget {
  const ItemsInformationScreen({super.key});

  @override
  ConsumerState<ItemsInformationScreen> createState() =>
      _ItemsInformationScreenState();
}

class _ItemsInformationScreenState
    extends ConsumerState<ItemsInformationScreen> {
  String? _selectedType;
  String? _weight;

  final _weights = ['4.5 KG', '5 KG', '6 KG', '7 KG'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      ref.read(itemTypesProvider.notifier).fetchItemTypes(),
      ref.read(packageTypeProvider.notifier).fetchpackageTypes(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of item types from the provider
    final itemTypes = ref.watch(itemTypesProvider);
    final packageTypes = ref.watch(packageTypeProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            // Description and Type
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                    label: "Description",
                    hint: "Vehicle Parts",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildDropdownField(
                    label: "Type",
                    hint: "Type",
                    items: itemTypes.map((item) => item.name!).toList(),
                    value: _selectedType,
                    isRequired: true,
                    onChanged: (value) => setState(() => _selectedType = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Quantity and Weight
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                    label: "Quantity",
                    hint: "Enter Quantity",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildDropdownField(
                    label: "Weight",
                    hint: "Select Weight",
                    items: _weights,
                    value: _weight,
                    isRequired: true,
                    onChanged: (value) => setState(() => _weight = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Value and Package Type
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                    label: "Value",
                    hint: "Enter value",
                    isRequired: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildDropdownField(
                    label: "Package Type",
                    hint: "Select Type",
                    items: packageTypes.map((item) => item.name!).toList(),
                    value: _weight,
                    isRequired: false,
                    onChanged: (value) => setState(() => _weight = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Value and Package Type
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                    label: "Quantity",
                    hint: "Enter value",
                    isRequired: false,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildTextField(
                    label: "PCs",
                    hint: "Enter pcs",
                    isRequired: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Dimension and Total Shipment
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Dimension (CM)',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          const Text(
                            "*",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Row(
                          children: [
                            _buildDimensionButton("W"),
                            _buildDivider(),
                            _buildDimensionButton("H"),
                            _buildDivider(),
                            _buildDimensionButton("L"),
                            _buildDivider(),
                            _buildDimensionButton("V"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildTextField(
                    label: """Total Shipment
(Qty*L*H*W)/5,000)""",
                    hint: "Enter Total Shipment",
                    isRequired: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Divider
            const Divider(
              color: Color(0xffB7B7B7),
              thickness: 1,
            ),
            const SizedBox(height: 20),

            // Shipment Charges
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shipment Charges",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                    label: "Value",
                    hint: 'Enter Value',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 53,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFFEE6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add, color: Colors.black),
                              const SizedBox(width: 5),
                              Text(
                                "Add",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownField({
    required String label,
    required String hint,
    required List<String> items,
    required String? value,
    required ValueChanged<String?> onChanged,
    required bool isRequired,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            if (isRequired)
              const Text(
                "*",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        CustomDropdownFormField<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
          isExpanded: true,
          hint: Text(
            hint,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
          ),
        ),
      ],
    );
  }

  // Reusable method to build text fields
  Widget buildTextField({
    required String label,
    required String hint,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            if (isRequired)
              const Text(
                "*",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        CustomTextFormField(
          autofocus: false,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          fillColor: const Color(0xffE7E7E7),
          filled: true,
          borderDecoration: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build dimension buttons
  Widget _buildDimensionButton(String label) {
    return Expanded(
      child: SizedBox(
        height: 53,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xffE7E7E7),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  // Helper method to build dividers
  Widget _buildDivider() {
    return const VerticalDivider(
      color: Colors.grey,
      thickness: 1,
      width: 1,
    );
  }
}
