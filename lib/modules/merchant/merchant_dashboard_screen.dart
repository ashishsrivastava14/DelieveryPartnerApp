import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class MerchantDashboardScreen extends StatelessWidget {
  const MerchantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isOpen = true.obs;
    final selectedPeriod = 'Today'.obs;

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
                      Text('Burger Kingdom', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700)),
                      Text('Welcome back, Vikram!', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary)),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.merchantColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.storefront_rounded, color: AppColors.merchantColor, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Store Status
              Obx(() => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isOpen.value
                        ? [const Color(0xFF2ECC71), const Color(0xFF58D68D)]
                        : [const Color(0xFF6B7280), const Color(0xFF9CA3AF)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(isOpen.value ? Icons.store_rounded : Icons.store_outlined, color: Colors.white, size: 24),
                        const SizedBox(width: 12),
                        Text(isOpen.value ? 'Store is Open' : 'Store is Closed', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                      ],
                    ),
                    Switch(
                      value: isOpen.value,
                      onChanged: (_) => isOpen.value = !isOpen.value,
                      activeThumbColor: Colors.white,
                      activeTrackColor: Colors.white.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 20),

              // Revenue Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF9A76)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: AppColors.merchantColor.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: Column(
                  children: [
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ['Today', 'Week', 'Month'].map((p) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(p),
                          selected: selectedPeriod.value == p,
                          onSelected: (_) => selectedPeriod.value = p,
                          selectedColor: Colors.white,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: selectedPeriod.value == p ? AppColors.merchantColor : Colors.white,
                          ),
                          showCheckmark: false,
                        ),
                      )).toList(),
                    )),
                    const SizedBox(height: 12),
                    Text('Revenue', style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
                    Obx(() => Text(
                      selectedPeriod.value == 'Today' ? '₹12,450' : selectedPeriod.value == 'Week' ? '₹87,200' : '₹3,45,800',
                      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Order Stats
              Text('Order Stats', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _statCard('New', '${MockData.merchantOrders.where((o) => o['status'] == 'New').length}', AppColors.info)),
                  const SizedBox(width: 10),
                  Expanded(child: _statCard('Preparing', '${MockData.merchantOrders.where((o) => o['status'] == 'Preparing').length}', AppColors.warning)),
                  const SizedBox(width: 10),
                  Expanded(child: _statCard('Completed', '24', AppColors.success)),
                ],
              ),
              const SizedBox(height: 24),

              // Top Items
              Text('Top Items Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              ...MockData.menuItems.take(5).map((item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.merchantColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Icon(Icons.fastfood_rounded, color: AppColors.merchantColor, size: 22)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(item['name'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500))),
                    Text('${item['orderCount']} orders', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 8)],
      ),
      child: Column(
        children: [
          Text(value, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 2),
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
