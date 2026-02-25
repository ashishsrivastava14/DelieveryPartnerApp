import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';

class OrderTrackingController extends GetxController {
  final currentStep = 0.obs;
  Timer? _timer;

  final steps = ['Confirmed', 'Preparing', 'Picked Up', 'Delivered'];
  
  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentStep.value < 3) {
        currentStep.value++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderTrackingController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Track Order', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.background,
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Placeholder
            Container(
              width: double.infinity,
              height: 220,
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
                        Icon(Icons.map_rounded, size: 48, color: AppColors.primary.withValues(alpha: 0.3)),
                        const SizedBox(height: 8),
                        Text('Live Map View', style: GoogleFonts.poppins(color: AppColors.textHint, fontSize: 13)),
                      ],
                    ),
                  ),
                  // Mock route markers
                  Positioned(top: 40, left: 60, child: Icon(Icons.restaurant_rounded, color: AppColors.accent, size: 28)),
                  Positioned(bottom: 50, right: 50, child: Icon(Icons.location_on_rounded, color: AppColors.primary, size: 32)),
                  Positioned(top: 100, left: 150, child: Icon(Icons.delivery_dining_rounded, color: AppColors.success, size: 30)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Order ID & ETA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #ORD-2026-002', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                      Text('Pizza Paradise', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('ETA: 25 min', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.success)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Status Stepper
            Text('Order Status', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Obx(() => Column(
              children: List.generate(controller.steps.length, (index) {
                final isActive = index <= controller.currentStep.value;
                final isCurrent = index == controller.currentStep.value;
                final isLast = index == controller.steps.length - 1;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.primary : AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(16),
                            border: isCurrent ? Border.all(color: AppColors.primary, width: 3) : null,
                            boxShadow: isCurrent ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8)] : null,
                          ),
                          child: isActive
                              ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                              : null,
                        ),
                        if (!isLast)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: 3,
                            height: 40,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.primary : AppColors.border,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.steps[index],
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                              color: isActive ? AppColors.textPrimary : AppColors.textHint,
                            ),
                          ),
                          if (isActive)
                            Text(
                              _getStepTime(index),
                              style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            )),
            const SizedBox(height: 24),

            // Rider Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.delivery_dining_rounded, color: AppColors.primary, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deepak M.', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: AppColors.secondary),
                            const SizedBox(width: 3),
                            Text('4.5', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                            const SizedBox(width: 8),
                            Text('• Your Delivery Partner', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.phone_rounded, color: AppColors.success, size: 22),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStepTime(int step) {
    switch (step) {
      case 0: return '12:15 PM';
      case 1: return '12:18 PM';
      case 2: return '12:35 PM';
      case 3: return '12:50 PM';
      default: return '';
    }
  }
}
