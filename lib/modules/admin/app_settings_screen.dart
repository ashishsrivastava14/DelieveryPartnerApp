import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final commissionRate = 15.0.obs;
    final surgeEnabled = true.obs;
    final surgeFactor = 1.5.obs;
    final minOrderValue = 99.0.obs;
    final maxDeliveryRadius = 10.0.obs;
    final autoAssign = true.obs;
    final maintenanceMode = false.obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Platform Settings', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('Configure app-wide settings', style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 20),

            // Commission
            _settingsCard(
              icon: Icons.percent_rounded,
              title: 'Commission Rate',
              child: Obx(() => Column(
                children: [
                  Row(
                    children: [
                      Text('${commissionRate.value.toStringAsFixed(0)}%', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.adminColor)),
                      const Spacer(),
                      Text('Platform commission on each order', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                  Slider(
                    value: commissionRate.value,
                    min: 5,
                    max: 30,
                    divisions: 25,
                    activeColor: AppColors.adminColor,
                    onChanged: (v) => commissionRate.value = v,
                  ),
                ],
              )),
            ),
            const SizedBox(height: 14),

            // Surge Pricing
            _settingsCard(
              icon: Icons.trending_up_rounded,
              title: 'Surge Pricing',
              child: Obx(() => Column(
                children: [
                  Row(
                    children: [
                      Text('Enable Surge', style: GoogleFonts.poppins(fontSize: 14)),
                      const Spacer(),
                      Switch(value: surgeEnabled.value, onChanged: (v) => surgeEnabled.value = v, activeThumbColor: AppColors.adminColor),
                    ],
                  ),
                  if (surgeEnabled.value) ...[
                    Row(
                      children: [
                        Text('Surge Factor: ${surgeFactor.value.toStringAsFixed(1)}x', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Slider(
                      value: surgeFactor.value,
                      min: 1.0,
                      max: 3.0,
                      divisions: 20,
                      activeColor: AppColors.accent,
                      onChanged: (v) => surgeFactor.value = v,
                    ),
                  ],
                ],
              )),
            ),
            const SizedBox(height: 14),

            // Min Order Value
            _settingsCard(
              icon: Icons.shopping_cart_rounded,
              title: 'Minimum Order Value',
              child: Obx(() => Column(
                children: [
                  Row(
                    children: [
                      Text('₹${minOrderValue.value.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.adminColor)),
                    ],
                  ),
                  Slider(
                    value: minOrderValue.value,
                    min: 0,
                    max: 500,
                    divisions: 50,
                    activeColor: AppColors.adminColor,
                    onChanged: (v) => minOrderValue.value = v,
                  ),
                ],
              )),
            ),
            const SizedBox(height: 14),

            // Max Delivery Radius
            _settingsCard(
              icon: Icons.radar_rounded,
              title: 'Max Delivery Radius',
              child: Obx(() => Column(
                children: [
                  Row(
                    children: [
                      Text('${maxDeliveryRadius.value.toStringAsFixed(0)} km', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.adminColor)),
                    ],
                  ),
                  Slider(
                    value: maxDeliveryRadius.value,
                    min: 3,
                    max: 25,
                    divisions: 22,
                    activeColor: AppColors.adminColor,
                    onChanged: (v) => maxDeliveryRadius.value = v,
                  ),
                ],
              )),
            ),
            const SizedBox(height: 14),

            // Toggles
            _settingsCard(
              icon: Icons.settings_suggest_rounded,
              title: 'Other Settings',
              child: Obx(() => Column(
                children: [
                  _toggleRow('Auto-assign Riders', 'Automatically assign nearest rider', autoAssign),
                  const Divider(),
                  _toggleRow('Maintenance Mode', 'Disable ordering for all users', maintenanceMode),
                ],
              )),
            ),
            const SizedBox(height: 14),

            // Notification Templates
            _settingsCard(
              icon: Icons.notifications_rounded,
              title: 'Notification Templates',
              child: Column(
                children: [
                  _templateTile('Order Confirmation', 'Your order #{{id}} is confirmed!'),
                  const Divider(),
                  _templateTile('Delivery Started', 'Your rider is on the way!'),
                  const Divider(),
                  _templateTile('Order Delivered', 'Your order has been delivered. Enjoy!'),
                  const Divider(),
                  _templateTile('Promo Alert', 'Use code {{code}} to get {{discount}}!'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar('Settings Saved', 'All settings have been updated successfully',
                      snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.adminColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text('Save Settings', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _settingsCard({required IconData icon, required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: AppColors.adminColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: AppColors.adminColor, size: 18),
              ),
              const SizedBox(width: 12),
              Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _toggleRow(String title, String subtitle, RxBool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
            ],
          )),
          Switch(value: value.value, onChanged: (v) => value.value = v, activeThumbColor: AppColors.adminColor),
        ],
      ),
    );
  }

  Widget _templateTile(String title, String template) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(template, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
            ],
          )),
          IconButton(
            onPressed: () => Get.snackbar('Edit', 'Template editor would open here', snackPosition: SnackPosition.BOTTOM),
            icon: const Icon(Icons.edit_rounded, size: 18, color: AppColors.adminColor),
          ),
        ],
      ),
    );
  }
}
