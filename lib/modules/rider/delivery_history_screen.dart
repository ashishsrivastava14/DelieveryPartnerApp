import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';

class DeliveryHistoryScreen extends StatelessWidget {
  const DeliveryHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Delivery History', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.background,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemCount: MockData.riderDeliveryHistory.length,
        itemBuilder: (context, index) {
          final del = MockData.riderDeliveryHistory[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8)],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(del['customer'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                      Text(del['address'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                      Text('${del['date']} • ${del['time']}', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textHint)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('₹${(del['amount'] as double).toInt()}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.riderColor)),
                    if ((del['tip'] as double) > 0)
                      Text('+₹${(del['tip'] as double).toInt()} tip', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
