import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';

class PromoManagementController extends GetxController {
  final promos = MockData.promoCodes.map((p) => Map<String, dynamic>.from(p)).toList().obs;

  void toggleActive(int index) {
    promos[index]['active'] = !(promos[index]['active'] as bool);
    promos.refresh();
  }

  void addPromo(String code, String discount, String minOrder, String expiry) {
    promos.add({
      'code': code,
      'discount': discount,
      'minOrder': minOrder,
      'expiry': expiry,
      'used': 0,
      'active': true,
    });
  }
}

class PromoManagementScreen extends StatelessWidget {
  const PromoManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromoManagementController());

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPromoDialog(context, controller),
        backgroundColor: AppColors.adminColor,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('New Promo', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: Obx(() => ListView.separated(
        padding: const EdgeInsets.all(20),
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemCount: controller.promos.length,
        itemBuilder: (context, index) {
          final promo = controller.promos[index];
          final isActive = promo['active'] as bool;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isActive ? AppColors.secondary.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: isActive
                            ? const LinearGradient(colors: [AppColors.secondary, AppColors.accent])
                            : LinearGradient(colors: [Colors.grey.shade300, Colors.grey.shade400]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(promo['code'] as String, style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isActive ? Colors.white : Colors.grey.shade600,
                        letterSpacing: 1,
                      )),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(promo['discount'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                        Text('Min: ₹${promo['minOrder']}', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    )),
                    Switch(
                      value: isActive,
                      onChanged: (_) => controller.toggleActive(index),
                      activeThumbColor: AppColors.secondary,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _promoInfo(Icons.calendar_today_rounded, 'Expires: ${promo['expiry']}'),
                    const Spacer(),
                    _promoInfo(Icons.people_rounded, 'Used ${promo['used']} times'),
                  ],
                ),
              ],
            ),
          );
        },
      )),
    );
  }

  Widget _promoInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textHint),
        const SizedBox(width: 4),
        Text(text, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }

  void _showAddPromoDialog(BuildContext context, PromoManagementController controller) {
    final codeC = TextEditingController();
    final discountC = TextEditingController();
    final minOrderC = TextEditingController(text: '200');
    final expiryC = TextEditingController(text: '2025-12-31');

    Get.dialog(AlertDialog(
      title: Text('Create Promo Code', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: codeC, decoration: const InputDecoration(labelText: 'Promo Code'), textCapitalization: TextCapitalization.characters),
          const SizedBox(height: 10),
          TextField(controller: discountC, decoration: const InputDecoration(labelText: 'Discount (e.g., 20% off)')),
          const SizedBox(height: 10),
          TextField(controller: minOrderC, decoration: const InputDecoration(labelText: 'Min Order (₹)'), keyboardType: TextInputType.number),
          const SizedBox(height: 10),
          TextField(controller: expiryC, decoration: const InputDecoration(labelText: 'Expiry Date')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (codeC.text.isNotEmpty && discountC.text.isNotEmpty) {
              controller.addPromo(codeC.text.toUpperCase(), discountC.text, minOrderC.text, expiryC.text);
              Get.back();
              Get.snackbar('Created', 'Promo ${codeC.text.toUpperCase()} added', snackPosition: SnackPosition.BOTTOM);
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.adminColor),
          child: Text('Create', style: GoogleFonts.poppins(color: Colors.white)),
        ),
      ],
    ));
  }
}
