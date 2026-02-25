import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';

class ActiveDeliveryController extends GetxController {
  final currentStep = 0.obs;
  final steps = ['Go to Restaurant', 'Pick Up Order', 'Deliver to Customer'];
  final actions = ['Arrived at Restaurant', 'Picked Up', 'Delivered (Enter OTP)'];

  void nextStep(BuildContext context) {
    if (currentStep.value == 2) {
      // Show OTP dialog
      _showOtpDialog(context);
    } else {
      currentStep.value++;
    }
  }

  void _showOtpDialog(BuildContext context) {
    final otpControllers = List.generate(4, (_) => TextEditingController());
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Enter Delivery OTP', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Ask customer for the 4-digit OTP', style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (i) => SizedBox(
                width: 50,
                child: TextField(
                  controller: otpControllers[i],
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.snackbar(
                'Delivery Complete! 🎉',
                'Great job! Earnings: ₹55 + ₹10 tip',
                backgroundColor: AppColors.success.withValues(alpha: 0.1),
                colorText: AppColors.success,
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 3),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Confirm', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class ActiveDeliveryScreen extends StatelessWidget {
  const ActiveDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActiveDeliveryController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Active Delivery', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.background,
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_rounded, size: 48, color: AppColors.riderColor.withValues(alpha: 0.3)),
                        const SizedBox(height: 8),
                        Text('Navigation Map', style: GoogleFonts.poppins(color: AppColors.textHint, fontSize: 13)),
                      ],
                    ),
                  ),
                  Positioned(top: 30, left: 40, child: Icon(Icons.restaurant_rounded, color: AppColors.accent, size: 28)),
                  Positioned(bottom: 40, right: 40, child: Icon(Icons.home_rounded, color: AppColors.primary, size: 28)),
                  Positioned(top: 80, left: 130, child: Icon(Icons.delivery_dining_rounded, color: AppColors.riderColor, size: 30)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Step Indicator
            Text('Delivery Progress', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Obx(() => Row(
              children: List.generate(3, (i) {
                final isActive = i <= controller.currentStep.value;
                final isCurrent = i == controller.currentStep.value;
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.riderColor : AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(16),
                          border: isCurrent ? Border.all(color: AppColors.riderColor, width: 3) : null,
                        ),
                        child: Center(
                          child: isActive && !isCurrent
                              ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                              : Text('${i + 1}', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: isActive ? Colors.white : AppColors.textHint)),
                        ),
                      ),
                      if (i < 2)
                        Expanded(
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: i < controller.currentStep.value ? AppColors.riderColor : AppColors.border,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            )),
            const SizedBox(height: 8),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: controller.steps.map((s) => SizedBox(
                width: 90,
                child: Text(s, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textSecondary), textAlign: TextAlign.center),
              )).toList(),
            )),
            const SizedBox(height: 24),

            // Order Details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Details', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _detailRow(Icons.storefront_rounded, 'Restaurant', 'Pizza Paradise\nMG Road, Kozhikode'),
                  const SizedBox(height: 12),
                  _detailRow(Icons.person_rounded, 'Customer', 'Priya Nair\nPalazhi Road, Kozhikode'),
                  const SizedBox(height: 12),
                  _detailRow(Icons.shopping_bag_rounded, 'Items', 'Margherita Pizza x1\nPepperoni Pizza x1\nCoca Cola x2'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Earnings for this delivery
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.riderColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.riderColor.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Earnings', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                  Text('₹55.00', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.riderColor)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action button
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.nextStep(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.riderColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 4,
                ),
                child: Text(
                  controller.actions[controller.currentStep.value],
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textHint)),
            Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}
