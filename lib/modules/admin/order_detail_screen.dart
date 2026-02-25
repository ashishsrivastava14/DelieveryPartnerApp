import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as Map<String, dynamic>;
    final status = (order['status'] as String).obs;

    final timeline = [
      {'title': 'Order Placed', 'time': '10:30 AM', 'done': true},
      {'title': 'Confirmed by Restaurant', 'time': '10:32 AM', 'done': true},
      {'title': 'Preparing', 'time': '10:35 AM', 'done': status.value != 'Pending' && status.value != 'Confirmed'},
      {'title': 'Picked Up', 'time': '10:50 AM', 'done': status.value == 'Picked Up' || status.value == 'Delivered'},
      {'title': 'Delivered', 'time': '11:05 AM', 'done': status.value == 'Delivered'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Order #${order['id']}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.adminColor, Color(0xFF2980B9)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #${order['id']}', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('${order['customer']} • ${order['items']} items', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                    ],
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                    child: Obx(() => Text(status.value, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Timeline
            Text('Order Timeline', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            ...List.generate(timeline.length, (i) {
              final step = timeline[i];
              final isDone = step['done'] as bool;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDone ? Colors.green : Colors.grey.shade300,
                        ),
                        child: isDone ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
                      ),
                      if (i < timeline.length - 1)
                        Container(width: 2, height: 36, color: isDone ? Colors.green : Colors.grey.shade300),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Expanded(child: Text(step['title'] as String, style: GoogleFonts.poppins(fontSize: 13, fontWeight: isDone ? FontWeight.w600 : FontWeight.w400, color: isDone ? AppColors.textPrimary : AppColors.textHint))),
                          if (isDone) Text(step['time'] as String, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 10),

            // Customer Info
            _sectionCard('Customer', [
              _row('Name', order['customer'] as String),
              _row('Phone', '+91 98765 43210'),
              _row('Address', '123 Main Street, Sector 45, Gurugram'),
            ]),

            const SizedBox(height: 14),

            // Merchant Info
            _sectionCard('Merchant', [
              _row('Store', 'Spice Junction'),
              _row('Phone', '+91 91234 56789'),
              _row('Address', '45 Food Street, Sector 29, Gurugram'),
            ]),

            const SizedBox(height: 14),

            // Rider Info
            _sectionCard('Rider', [
              _row('Name', 'Amit Kumar'),
              _row('Phone', '+91 99887 76655'),
              _row('Vehicle', 'Bike - DL 05 AB 1234'),
            ]),

            const SizedBox(height: 14),

            // Order Items
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700)),
                  const Divider(),
                  _itemRow('Chicken Biryani x1', '₹280'),
                  _itemRow('Paneer Tikka x2', '₹360'),
                  _itemRow('Garlic Naan x3', '₹120'),
                  const Divider(),
                  _itemRow('Subtotal', '₹760'),
                  _itemRow('Delivery Fee', '₹40'),
                  _itemRow('Tax (5%)', '₹38'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                      Text('₹${order['total']}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Actions
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        status.value = 'Cancelled';
                        Get.snackbar('Order Cancelled', 'Order #${order['id']} has been cancelled', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                      },
                      icon: const Icon(Icons.cancel_rounded),
                      label: Text('Cancel', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.snackbar('Refund Initiated', '₹${order['total']} refund processed', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
                      },
                      icon: const Icon(Icons.replay_rounded),
                      label: Text('Refund', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.adminColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _itemRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 13)),
          Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
