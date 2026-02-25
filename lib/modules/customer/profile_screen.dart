import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Profile header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
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
                      child: const Icon(Icons.person_rounded, color: Colors.white, size: 44),
                    ),
                    const SizedBox(height: 12),
                    Text('Rahul Sharma', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                    Text('rahul@email.com', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      ),
                      child: Text('Edit Profile', style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Menu items
              _buildTile(Icons.location_on_outlined, 'My Addresses', '2 saved addresses', () {}),
              _buildTile(Icons.account_balance_wallet_outlined, 'Wallet', '₹250.00 balance', () {}),
              _buildTile(Icons.notifications_outlined, 'Notifications', '3 unread', () {}),
              _buildTile(Icons.headset_mic_outlined, 'Help & Support', null, () {}),
              _buildTile(Icons.info_outline_rounded, 'About', 'v1.0.0', () {}),
              const SizedBox(height: 12),
              _buildTile(
                Icons.logout_rounded,
                'Logout',
                null,
                () => Get.offAllNamed(AppRoutes.roleSelection),
                iconColor: AppColors.error,
                textColor: AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String? subtitle, VoidCallback onTap, {Color? iconColor, Color? textColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor ?? AppColors.primary, size: 22),
        ),
        title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: textColor ?? AppColors.textPrimary)),
        subtitle: subtitle != null ? Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)) : null,
        trailing: Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
