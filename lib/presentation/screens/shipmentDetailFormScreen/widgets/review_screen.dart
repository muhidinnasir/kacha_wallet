import 'package:flutter/material.dart';

class ShipmentReviewScreen extends StatefulWidget {
  const ShipmentReviewScreen({super.key});

  @override
  State<ShipmentReviewScreen> createState() => _ShipmentReviewScreenState();
}

class _ShipmentReviewScreenState extends State<ShipmentReviewScreen> {
  // Reusable method to build key-value rows
  Widget _buildInfoRow(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const divider = Divider(color: Colors.grey);
    const sectionSpacing = SizedBox(height: 20);
    const rowSpacing = SizedBox(height: 10);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Direction Information
          const Text(
            'Direction Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          rowSpacing,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow('Domestic: ', 'Ethiopia'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('From City: ', 'Addis Ababa'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('To City: ', 'Dire Dawa'),
              ],
            ),
          ),
          sectionSpacing,

          // Item Information
          const Text(
            'Item Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          rowSpacing,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow('Item Name: ', 'Electronics'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow(
                    'Item Description: ', 'Electronics item for shipment'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Item Type: ', 'Electronics'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Item Quantity: ', '1'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Item Pieces: ', '1'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Item Weight: ', '2 kg'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Item Value: ', '1000 ETB'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Item Package Type: ', 'Box'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Item Dimensions: ', '10x10x10 cm'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Total Shipment Value: ', '1000 ETB'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Shipment Charge: ', '100 ETB'),
              ],
            ),
          ),
          sectionSpacing,

          // Sender Information
          const Text(
            'Sender Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          rowSpacing,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow('Full Name:', 'Muhammad Ali'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Country:', 'Ethiopia'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('City:', 'Addis Ababa'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Subcity:', 'Addis Ababa'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('House Number:', '123'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Phone:', '0912345678'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Email:', 'example@gmail.com'),
              ],
            ),
          ),
          sectionSpacing,

          // Receiver Information
          const Text(
            'Receiver Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          rowSpacing,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow('Full Name:', 'Muhammad Ali'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Country:', 'Ethiopia'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('City:', 'Addis Ababa'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Subcity:', 'Addis Ababa'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('House Number:', '123'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Phone:', '0912345678'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Email:', 'example@gmail.com'),
              ],
            ),
          ),
          sectionSpacing,

          // Payment Information
          const Text(
            'Payment Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          rowSpacing,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow('Payment Method: ', 'Cash on Delivery'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Bank Name: ', 'CBE'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Transaction Number: ', '123456789'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Insurance: ', 'Yes'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Packaging: ', 'Yes'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Total Charge: ', '100 ETB'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('VAT: ', '15%'),
                rowSpacing,
                divider,
                rowSpacing,
                _buildInfoRow('Grand Total: ', '115 ETB'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
