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
      {
        'title': 'Customer',
        'icon': Icons.shopping_bag_rounded,
        'desc': 'Order food & essentials delivered fast',
        'gradient': const [Color(0xFF6C3CE1), Color(0xFF9B7BF7)],
        'accent': const Color(0xFF6C3CE1),
        'tag': 'Shop Now',
      },
      {
        'title': 'Rider',
        'icon': Icons.delivery_dining_rounded,
        'desc': 'Deliver orders & earn on your schedule',
        'gradient': const [Color(0xFF1DB954), Color(0xFF52D68A)],
        'accent': const Color(0xFF1DB954),
        'tag': 'Start Earning',
      },
      {
        'title': 'Merchant',
        'icon': Icons.storefront_rounded,
        'desc': 'List products & grow your business',
        'gradient': const [Color(0xFFFF6B35), Color(0xFFFF9A76)],
        'accent': const Color(0xFFFF6B35),
        'tag': 'Manage Store',
      },
      {
        'title': 'Admin',
        'icon': Icons.admin_panel_settings_rounded,
        'desc': 'Oversee and manage the entire platform',
        'gradient': const [Color(0xFF1A73E8), Color(0xFF74B9FF)],
        'accent': const Color(0xFF1A73E8),
        'tag': 'Control Panel',
      },
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
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/delivery_bg_light.png',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.delivery_dining_rounded, size: 28, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('DeliverEase', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                            Text('Fast • Reliable • Everywhere', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text('Who are you?', style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary, height: 1.1)),
                    const SizedBox(height: 4),
                    Text('Select your role to get started', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary)),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.separated(
                        itemCount: roles.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final role = roles[index];
                          return _RoleCard(
                            title: role['title'] as String,
                            icon: role['icon'] as IconData,
                            description: role['desc'] as String,
                            gradientColors: role['gradient'] as List<Color>,
                            accentColor: role['accent'] as Color,
                            tag: role['tag'] as String,
                            index: index + 1,
                            onTap: () => Get.toNamed(AppRoutes.login, arguments: role['title']),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
  final Color accentColor;
  final String tag;
  final int index;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.gradientColors,
    required this.accentColor,
    required this.tag,
    required this.index,
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
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withValues(alpha: 0.15),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Colored left accent bar
              Container(
                width: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.gradientColors,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Icon container
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: widget.accentColor.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(widget.icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(widget.title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: widget.accentColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(widget.tag, style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w600, color: widget.accentColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(widget.description, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              // Arrow
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: widget.accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward_rounded, color: widget.accentColor, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
