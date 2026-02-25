import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.arguments as Map<String, dynamic>;
    final isActive = (user['status'] == 'Active').obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('User Details', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.adminColor, Color(0xFF2980B9)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text(
                      (user['name'] as String).substring(0, 1),
                      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
                    )),
                  ),
                  const SizedBox(height: 14),
                  Text(user['name'] as String, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text(user['email'] as String, style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                    child: Text(user['role'] as String, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Info tiles
            _infoTile('Phone', '+91 98765 43210', Icons.phone_rounded),
            _infoTile('Joined', user['joined'] as String, Icons.calendar_today_rounded),
            _infoTile('Total Orders', '${user['orders']}', Icons.shopping_bag_rounded),
            _infoTile('Revenue Generated', '₹${user['revenue']}', Icons.currency_rupee_rounded),
            if (user['role'] == 'Rider')
              _infoTile('Rating', '4.7 ★', Icons.star_rounded),
            if (user['role'] == 'Merchant')
              _infoTile('Store Rating', '4.5 ★', Icons.store_rounded),

            const SizedBox(height: 20),

            // Recent Orders
            SectionHeader(title: 'Recent Orders', actionText: ''),
            const SizedBox(height: 10),
            ...List.generate(3, (i) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.receipt_long_rounded, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #${10045 + i}', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                      Text('${2 + i} items • ₹${(250 + i * 120).toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  )),
                  StatusChip(
                    label: i == 0 ? 'Delivered' : i == 1 ? 'Cancelled' : 'Delivered',
                    color: i == 1 ? Colors.red : Colors.green,
                  ),
                ],
              ),
            )),

            const SizedBox(height: 20),

            // Toggle account status
            Obx(() => SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  isActive.value = !isActive.value;
                  Get.snackbar(
                    'Status Updated',
                    'User is now ${isActive.value ? "Active" : "Suspended"}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: isActive.value ? Colors.green : Colors.red,
                    colorText: Colors.white,
                  );
                },
                icon: Icon(isActive.value ? Icons.block_rounded : Icons.check_circle_rounded),
                label: Text(isActive.value ? 'Suspend Account' : 'Activate Account', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive.value ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.adminColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: AppColors.adminColor, size: 20),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
              Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
