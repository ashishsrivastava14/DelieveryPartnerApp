import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class RiderProfileScreen extends StatelessWidget {
  const RiderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rider = MockData.riderProfile;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Profile card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF2ECC71), Color(0xFF58D68D)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(Icons.delivery_dining_rounded, color: Colors.white, size: 44),
                    ),
                    const SizedBox(height: 12),
                    Text(rider['name'] as String, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                    Text(rider['phone'] as String, style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                    const SizedBox(height: 10),
                    // Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(5, (i) => Icon(
                          i < (rider['rating'] as double).floor() ? Icons.star_rounded : (i < (rider['rating'] as double) ? Icons.star_half_rounded : Icons.star_outline_rounded),
                          color: AppColors.secondary,
                          size: 22,
                        )),
                        const SizedBox(width: 6),
                        Text('${rider['rating']}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${rider['totalDeliveries']} deliveries', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Document Status
              Text('Document Status', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _docRow('Driving License', rider['licenseStatus'] as String),
                    const Divider(height: 20),
                    _docRow('Vehicle RC', rider['rcStatus'] as String),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Vehicle Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vehicle Details', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _infoRow('Type', rider['vehicleType'] as String),
                    _infoRow('Number', rider['vehicleNumber'] as String),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bank Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bank Details', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _infoRow('Account', rider['bankAccount'] as String),
                    _infoRow('IFSC', rider['ifsc'] as String),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Logout
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Get.offAllNamed(AppRoutes.roleSelection),
                  icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                  label: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.error)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _docRow(String title, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
        StatusChip(label: status, color: statusColor(status)),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
          Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
