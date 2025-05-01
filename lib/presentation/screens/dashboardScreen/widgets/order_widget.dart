import 'package:flutter/material.dart';
import 'package:remittance_app/presentation/widgets/custom_image_view.dart';

import '../../../../core/image_constants.dart';

class Order {
  final String id;
  final DateTime date;
  final String status;
  final String pickupLocation;
  final String deliveryLocation;
  final double amount;
  final String details;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.amount,
    required this.details,
  });
}

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    // display the order details in a card format
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '123456',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 7.0,
                  ),
                  child: Text(
                    'Assigned',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // divider line
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Coffee, Sugar, Salt, Beer, Medicine',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 18.0),
            // display the order pickup location, delivery location in a row format
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.mapPin,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Djibouti, Dijibouti',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.mapPin,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Addis Ababa, Ethiopia',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            // date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.calendar,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '${DateTime.now().toLocal().month}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.calendar,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '${DateTime.now().toLocal()}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Text(
              'Order Date: ${DateTime.now().toLocal()}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Status: Pending',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Pickup Location: City Center',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Delivery Location: Downtown',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Amount: \$100.00',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle order action
              },
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}
