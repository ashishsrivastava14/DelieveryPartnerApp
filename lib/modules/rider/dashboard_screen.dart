import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';

class RiderDashboardController extends GetxController {
  final isOnline = false.obs;
  final deliveriesToday = 8.obs;
  final earningsToday = 520.0.obs;
  final hoursOnline = 5.5.obs;
  final hasActiveDelivery = true.obs;

  void toggleOnline() => isOnline.value = !isOnline.value;

  void showNewOrderRequest(BuildContext context) {
    final countdown = 15.obs;
    Timer? timer;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        t.cancel();
        if (Get.isBottomSheetOpen ?? false) Get.back();
      }
    });

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(4))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('New Order Request!', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: countdown.value <= 5 ? AppColors.error.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${countdown.value}s',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: countdown.value <= 5 ? AppColors.error : AppColors.primary),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _infoRow(Icons.storefront_rounded, 'Burger Kingdom', 'MG Road, Kozhikode'),
                  const Divider(height: 20),
                  _infoRow(Icons.person_rounded, 'Rahul Sharma', 'Rose Garden Apts, 2.3 km'),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _stat('Distance', '2.3 km'),
                      _stat('Earnings', '₹55'),
                      _stat('Items', '3'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      timer?.cancel();
                      Get.back();
                      Get.snackbar('Rejected', 'Order request declined', backgroundColor: AppColors.error.withValues(alpha: 0.1), colorText: AppColors.error, snackPosition: SnackPosition.BOTTOM);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.error),
                      foregroundColor: AppColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text('Reject', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      timer?.cancel();
                      Get.back();
                      Get.toNamed(AppRoutes.activeDelivery);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text('Accept Order', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      isDismissible: false,
    );
  }

  static Widget _infoRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
            Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ],
    );
  }

  static Widget _stat(String label, String value) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary)),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }
}

class RiderDashboardScreen extends StatelessWidget {
  const RiderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RiderDashboardController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello, Arjun 👋', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700)),
                      Text('Ready to deliver?', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary)),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.riderColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.delivery_dining_rounded, color: AppColors.riderColor, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Online/Offline Toggle
              Obx(() => Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: controller.isOnline.value
                        ? [const Color(0xFF2ECC71), const Color(0xFF58D68D)]
                        : [const Color(0xFF6B7280), const Color(0xFF9CA3AF)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (controller.isOnline.value ? AppColors.success : AppColors.textHint).withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.isOnline.value ? 'You are Online' : 'You are Offline',
                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        Text(
                          controller.isOnline.value ? 'Accepting new orders' : 'Go online to receive orders',
                          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 1.3,
                      child: Switch(
                        value: controller.isOnline.value,
                        onChanged: (_) => controller.toggleOnline(),
                        activeColor: Colors.white,
                        activeTrackColor: Colors.white.withValues(alpha: 0.3),
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
                        inactiveThumbColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 20),

              // Today's Stats
              Text("Today's Stats", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _statCard('Deliveries', '8', Icons.local_shipping_rounded, AppColors.primary)),
                  const SizedBox(width: 10),
                  Expanded(child: _statCard('Earnings', '₹520', Icons.account_balance_wallet_rounded, AppColors.success)),
                  const SizedBox(width: 10),
                  Expanded(child: _statCard('Hours', '5.5h', Icons.access_time_rounded, AppColors.accent)),
                ],
              ),
              const SizedBox(height: 24),

              // Active Delivery
              Obx(() => controller.hasActiveDelivery.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Active Delivery', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.activeDelivery),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                              boxShadow: [BoxShadow(color: AppColors.success.withValues(alpha: 0.08), blurRadius: 12)],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.success.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(Icons.delivery_dining_rounded, color: AppColors.success),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Priya Nair', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                                          Text('Palazhi Road, Kozhikode', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.warning.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text('Picking Up', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.warning)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => Get.toNamed(AppRoutes.activeDelivery),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.success,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: Text('View Delivery', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 24),

              // New Order Request Button (for demo)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => controller.showNewOrderRequest(context),
                  icon: const Icon(Icons.notification_add_rounded),
                  label: Text('Simulate New Order Request', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.riderColor),
                    foregroundColor: AppColors.riderColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
