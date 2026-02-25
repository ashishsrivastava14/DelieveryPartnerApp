import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAddress = 0.obs;
    final selectedPayment = 'UPI'.obs;
    final paymentMethods = ['COD', 'UPI', 'Card'];
    final paymentIcons = {
      'COD': Icons.money_rounded,
      'UPI': Icons.account_balance_rounded,
      'Card': Icons.credit_card_rounded,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Checkout', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.background,
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Text('Delivery Address', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...MockData.addresses.asMap().entries.map((entry) {
              final i = entry.key;
              final addr = entry.value;
              return Obx(() => GestureDetector(
                onTap: () => selectedAddress.value = i,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selectedAddress.value == i ? AppColors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (selectedAddress.value == i ? AppColors.primary : AppColors.textHint).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          addr['icon'] == 'home' ? Icons.home_rounded : Icons.work_rounded,
                          color: selectedAddress.value == i ? AppColors.primary : AppColors.textHint,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(addr['label'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(addr['address'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary), maxLines: 2),
                          ],
                        ),
                      ),
                      Radio<int>(
                        value: i,
                        groupValue: selectedAddress.value,
                        onChanged: (val) => selectedAddress.value = val!,
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ));
            }),
            const SizedBox(height: 20),

            // Payment Method
            Text('Payment Method', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...paymentMethods.map((method) {
              return Obx(() => GestureDetector(
                onTap: () => selectedPayment.value = method,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selectedPayment.value == method ? AppColors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (selectedPayment.value == method ? AppColors.primary : AppColors.textHint).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(paymentIcons[method], color: selectedPayment.value == method ? AppColors.primary : AppColors.textHint, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          method == 'COD' ? 'Cash on Delivery' : method == 'UPI' ? 'UPI Payment' : 'Credit / Debit Card',
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Radio<String>(
                        value: method,
                        groupValue: selectedPayment.value,
                        onChanged: (val) => selectedPayment.value = val!,
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ));
            }),
            const SizedBox(height: 20),

            // Order summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _summaryRow('Subtotal', '₹816'),
                  _summaryRow('Delivery Fee', '₹40'),
                  _summaryRow('Tax (5%)', '₹41'),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
                      Text('₹897', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, -4))],
        ),
        child: SafeArea(
          child: GradientButton(
            text: 'Place Order  •  ₹897',
            onPressed: () => Get.offNamed(AppRoutes.orderTracking),
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
          Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
