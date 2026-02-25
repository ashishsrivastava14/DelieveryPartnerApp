import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = [
      {'title': 'Customer', 'icon': Icons.shopping_bag_rounded, 'color': AppColors.customerColor, 'desc': 'Order food & essentials', 'gradient': const [Color(0xFF6C3CE1), Color(0xFF9B7BF7)]},
      {'title': 'Rider', 'icon': Icons.delivery_dining_rounded, 'color': AppColors.riderColor, 'desc': 'Deliver & earn money', 'gradient': const [Color(0xFF2ECC71), Color(0xFF58D68D)]},
      {'title': 'Merchant', 'icon': Icons.storefront_rounded, 'color': AppColors.merchantColor, 'desc': 'Manage your store', 'gradient': const [Color(0xFFFF6B35), Color(0xFFFF9A76)]},
      {'title': 'Admin', 'icon': Icons.admin_panel_settings_rounded, 'color': AppColors.adminColor, 'desc': 'Manage the platform', 'gradient': const [Color(0xFF3498DB), Color(0xFF74B9FF)]},
    ];

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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delivery_dining_rounded, size: 36, color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                Text('Welcome to\nDeliverEase', style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.2)),
                const SizedBox(height: 8),
                Text('Choose your role to continue', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                const SizedBox(height: 36),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: roles.length,
                    itemBuilder: (context, index) {
                      final role = roles[index];
                      return _RoleCard(
                        title: role['title'] as String,
                        icon: role['icon'] as IconData,
                        description: role['desc'] as String,
                        gradientColors: role['gradient'] as List<Color>,
                        onTap: () => Get.toNamed(AppRoutes.login, arguments: role['title']),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String description;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  State<_RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<_RoleCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors.first.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(widget.icon, color: Colors.white, size: 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                    const SizedBox(height: 2),
                    Text(widget.description, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
