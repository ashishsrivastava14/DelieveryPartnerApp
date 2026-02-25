import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Orders', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.background,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemCount: MockData.orders.length,
        itemBuilder: (context, index) {
          final order = MockData.orders[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order['store'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                    StatusChip(label: order['status'] as String, color: statusColor(order['status'] as String)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  (order['items'] as List).join(', '),
                  style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${order['date']} • ${order['time']}', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textHint)),
                    Text('₹${(order['total'] as double).toInt()}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ],
                ),
                if (order['status'] == 'Delivered') ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Get.snackbar('Reorder', 'Items added to cart!',
                          backgroundColor: AppColors.success.withValues(alpha: 0.1),
                          colorText: AppColors.success,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      icon: const Icon(Icons.replay_rounded, size: 18),
                      label: Text('Reorder', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
