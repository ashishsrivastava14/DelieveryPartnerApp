import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _cardAnimations;
  late Animation<double> _headerAnimation;

  final roles = const [
    {
      'title': 'Customer',
      'icon': Icons.shopping_bag_rounded,
      'desc': 'Features: order food, essentials, track deliveries, etc.',
      'gradient': [Color(0xFF7B2FBE), Color(0xFFAB6FE8)],
      'accent': Color(0xFF7B2FBE),
      'overlay': Color(0xFF7B2FBE),
      'image': 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=400&q=80',
    },
    {
      'title': 'Rider',
      'icon': Icons.delivery_dining_rounded,
      'desc': 'Features: deliver orders, earnings, schedule, etc.',
      'gradient': [Color(0xFF0D9F6E), Color(0xFF34D399)],
      'accent': Color(0xFF0D9F6E),
      'overlay': Color(0xFF0D9F6E),
      'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80',
    },
    {
      'title': 'Merchant',
      'icon': Icons.storefront_rounded,
      'desc': 'Features: manage store, products, orders, etc.',
      'gradient': [Color(0xFF2563EB), Color(0xFF60A5FA)],
      'accent': Color(0xFF2563EB),
      'overlay': Color(0xFF2563EB),
      'image': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&q=80',
    },
    {
      'title': 'Admin',
      'icon': Icons.admin_panel_settings_rounded,
      'desc': 'Features: platform oversight, analytics, users, etc.',
      'gradient': [Color(0xFFDB2777), Color(0xFFF472B6)],
      'accent': Color(0xFFDB2777),
      'overlay': Color(0xFFDB2777),
      'image': 'https://images.unsplash.com/photo-1551434678-e076c223a692?w=400&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _headerAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
    );

    _cardAnimations = List.generate(4, (index) {
      final start = 0.15 + (index * 0.12);
      final end = math.min(start + 0.45, 1.0);
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutBack),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Full-screen background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/role_bg_1.png',
                fit: BoxFit.cover,
              ),
            ),
            // Dark scrim so content stays readable
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
              ),
            ),
            // Scrollable content
            Positioned.fill(
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        // Logo
                        FadeTransition(
                          opacity: _headerAnimation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, -0.4),
                              end: Offset.zero,
                            ).animate(_headerAnimation),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 280,
                              height: 280,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Title & subtitle
                        FadeTransition(
                          opacity: _headerAnimation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, -0.3),
                              end: Offset.zero,
                            ).animate(_headerAnimation),
                            child: Column(
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [Color(0xFFE0CFFF), Color(0xFFFFD6C0)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds),
                                  child: Text(
                                    'Choose your role',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      height: 1.15,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Each role has its own supporting features.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withValues(alpha: 0.75),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        // Staggered grid of role cards
                        _buildStaggeredGrid(context),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaggeredGrid(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column
        Expanded(
          child: Column(
            children: [
              _buildAnimatedCard(0),
              const SizedBox(height: 16),
              _buildAnimatedCard(2),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Right column — offset downward for staggered feel
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                _buildAnimatedCard(1),
                const SizedBox(height: 16),
                _buildAnimatedCard(3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedCard(int index) {
    final role = roles[index];
    return AnimatedBuilder(
      listenable: _cardAnimations[index],
      builder: (context, child) {
        return Transform.scale(
          scale: _cardAnimations[index].value,
          child: Opacity(
            opacity: _cardAnimations[index].value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: _RoleCard(
        title: role['title'] as String,
        icon: role['icon'] as IconData,
        description: role['desc'] as String,
        gradientColors: role['gradient'] as List<Color>,
        accentColor: role['accent'] as Color,
        overlayColor: role['overlay'] as Color,
        imageUrl: role['image'] as String,
        onTap: () => Get.toNamed(AppRoutes.login, arguments: role['title']),
      ),
    );
  }
}

class AnimatedBuilder extends AnimatedWidget {
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  const AnimatedBuilder({
    super.key,
    required super.listenable,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }

  Animation<double> get animation => listenable as Animation<double>;
}

class _RoleCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String description;
  final List<Color> gradientColors;
  final Color accentColor;
  final Color overlayColor;
  final String imageUrl;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.gradientColors,
    required this.accentColor,
    required this.overlayColor,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<_RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<_RoleCard>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _hoverController;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _elevationAnimation = Tween<double>(begin: 8, end: 16).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _hoverController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _hoverController.reverse();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _hoverController.reverse();
      },
      onTap: widget.onTap,
      child: AnimatedBuilder(
        listenable: _elevationAnimation,
        builder: (context, child) {
          return AnimatedScale(
            scale: _isPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: widget.accentColor.withValues(alpha: 0.3),
                    blurRadius: _elevationAnimation.value,
                    offset: const Offset(0, 6),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(
                  aspectRatio: 0.72,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: widget.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          loadingBuilder: (_, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: widget.gradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Tinted color overlay so text stays legible
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.overlayColor.withValues(alpha: 0.55),
                                widget.overlayColor.withValues(alpha: 0.72),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      // Decorative circles / pattern overlay
                      Positioned(
                        top: -20,
                        right: -20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60,
                        left: -30,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.06),
                          ),
                        ),
                      ),
                      // Large icon in the center-top area
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(
                              widget.icon,
                              color: Colors.white,
                              size: 38,
                            ),
                          ),
                        ),
                      ),
                      // Bottom content area
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.overlayColor.withValues(alpha: 0.0),
                                widget.overlayColor.withValues(alpha: 0.85),
                                widget.overlayColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.description,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withValues(alpha: 0.85),
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              // "Select Role" button
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.15),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Select Role',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: widget.accentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
