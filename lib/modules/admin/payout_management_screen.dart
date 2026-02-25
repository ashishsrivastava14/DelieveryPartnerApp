import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class PayoutManagementScreen extends StatelessWidget {
  const PayoutManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payouts = MockData.payouts.map((p) => Map<String, dynamic>.from(p)).toList().obs;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // Summary
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: _summaryCard('Pending', '₹48,500', Colors.orange)),
                  const SizedBox(width: 12),
                  Expanded(child: _summaryCard('Processed', '₹2,34,000', Colors.green)),
                ],
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Rider Payouts'),
                Tab(text: 'Merchant Settlements'),
              ],
            ),
            Expanded(
              child: Obx(() => TabBarView(
                children: [
                  _buildPayoutList(payouts.where((p) => p['type'] == 'Rider').toList(), payouts),
                  _buildPayoutList(payouts.where((p) => p['type'] == 'Merchant').toList(), payouts),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String label, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(amount, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  Widget _buildPayoutList(List<Map<String, dynamic>> filtered, RxList<Map<String, dynamic>> payouts) {
    if (filtered.isEmpty) {
      return Center(child: Text('No payouts found', style: GoogleFonts.poppins(color: AppColors.textHint)));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final payout = filtered[index];
        final isPending = payout['status'] == 'Pending';

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.adminColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(
                      (payout['name'] as String).substring(0, 1),
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.adminColor),
                    )),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(payout['name'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                      Text(payout['period'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${payout['amount']}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      StatusChip(label: payout['status'] as String, color: statusColor(payout['status'] as String)),
                    ],
                  ),
                ],
              ),
              if (isPending) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      payout['status'] = 'Processed';
                      payouts.refresh();
                      Get.snackbar('Payout Processed', '₹${payout['amount']} paid to ${payout['name']}',
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Process Payout', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
