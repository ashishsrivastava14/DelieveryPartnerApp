import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = Get.arguments as String? ?? 'Customer';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F3FF), Color(0xFFEDE7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(height: 16),
                Image.asset('assets/images/logo.png', width: 144, height: 144, fit: BoxFit.contain),
                const SizedBox(height: 12),
                Text('Create Account', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Register as $role', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                const SizedBox(height: 32),
                _buildLabel('Full Name'),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
                    prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.textHint),
                  ),
                ),
                const SizedBox(height: 16),
                _buildLabel('Email Address'),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.textHint),
                  ),
                ),
                const SizedBox(height: 16),
                _buildLabel('Phone Number'),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '+91 XXXXX XXXXX',
                    prefixIcon: Icon(Icons.phone_outlined, color: AppColors.textHint),
                  ),
                ),
                if (role == 'Rider') ..._riderFields(),
                if (role == 'Merchant') ..._merchantFields(),
                const SizedBox(height: 16),
                _buildLabel('Password'),
                const SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Create a password',
                    prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.textHint),
                  ),
                ),
                const SizedBox(height: 32),
                GradientButton(
                  text: 'Create Account',
                  onPressed: () => _navigateToRole(role),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text('Sign In', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _riderFields() {
    return [
      const SizedBox(height: 16),
      _buildLabel('Vehicle Type'),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          hintText: 'e.g. Bike, Scooter, Car',
          prefixIcon: Icon(Icons.two_wheeler_rounded, color: AppColors.textHint),
        ),
      ),
      const SizedBox(height: 16),
      _buildLabel('License Number'),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          hintText: 'Enter license number',
          prefixIcon: Icon(Icons.badge_outlined, color: AppColors.textHint),
        ),
      ),
    ];
  }

  List<Widget> _merchantFields() {
    return [
      const SizedBox(height: 16),
      _buildLabel('Store Name'),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          hintText: 'Enter your store name',
          prefixIcon: Icon(Icons.storefront_outlined, color: AppColors.textHint),
        ),
      ),
      const SizedBox(height: 16),
      _buildLabel('Store Address'),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          hintText: 'Enter store address',
          prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.textHint),
        ),
      ),
    ];
  }

  Widget _buildLabel(String text) {
    return Text(text, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary));
  }

  void _navigateToRole(String role) {
    switch (role) {
      case 'Customer':
        Get.offAllNamed(AppRoutes.customerShell);
        break;
      case 'Rider':
        Get.offAllNamed(AppRoutes.riderShell);
        break;
      case 'Merchant':
        Get.offAllNamed(AppRoutes.merchantShell);
        break;
      case 'Admin':
        Get.offAllNamed(AppRoutes.adminShell);
        break;
    }
  }
}
