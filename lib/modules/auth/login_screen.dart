import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = Get.arguments as String? ?? 'Customer';
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final obscure = true.obs;

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
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/logo.png',
                  width: 144,
                  height: 144,
                  fit: BoxFit.contain,
                  semanticLabel: 'DeliverEase logo',
                ),
                const SizedBox(height: 16),
                Text('Welcome back!', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Sign in as $role', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                const SizedBox(height: 40),
                _buildLabel('Email Address'),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.textHint),
                  ),
                ),
                const SizedBox(height: 20),
                _buildLabel('Password'),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: passwordController,
                  obscureText: obscure.value,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.textHint),
                    suffixIcon: IconButton(
                      icon: Icon(obscure.value ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textHint),
                      onPressed: () => obscure.value = !obscure.value,
                    ),
                  ),
                )),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(height: 24),
                GradientButton(
                  text: 'Sign In',
                  onPressed: () {
                    _navigateToRole(role);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('or continue with', style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textHint)),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(Icons.g_mobiledata_rounded, 'Google'),
                    const SizedBox(width: 16),
                    _socialButton(Icons.phone_android_rounded, 'Phone'),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: GoogleFonts.poppins(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.register, arguments: role),
                      child: Text('Register', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary));
  }

  Widget _socialButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: AppColors.textPrimary),
          const SizedBox(width: 8),
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        ],
      ),
    );
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
