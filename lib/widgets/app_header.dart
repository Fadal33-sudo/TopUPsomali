import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../core/constants.dart';
import 'custom_button.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: Border(bottom: BorderSide(color: AppColors.grayBorder)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 16
            : (MediaQuery.of(context).size.width - AppConstants.maxWidth)
                    .clamp(20, double.infinity) /
                2,
      ),
      child: Row(
        children: [
          // Logo
          InkWell(
            onTap: () => context.go('/'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.flash_on,
                    color: AppColors.primaryBlue, size: 30),
                const SizedBox(width: 8),
                if (!isMobile || MediaQuery.of(context).size.width > 350)
                  Text(
                    AppConstants.appName,
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
              ],
            ),
          ),

          if (isDesktop) ...[
            const SizedBox(width: 40),
            _navItem('Home', () => context.go('/')),
            _navItem('PUBG Mobile', () => context.go('/game/pubg')),
            _navItem('Free Fire', () => context.go('/game/freefire')),
            _navItem('eFootball', () => context.go('/game/efootball')),
          ],

          const Spacer(),

          // Search Bar (Desktop only)
          if (isDesktop)
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search games...',
                    hintStyle: const TextStyle(fontSize: 14),
                    prefixIcon: const Icon(Icons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    fillColor: AppColors.cardBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

          if (!isMobile) ...[
            CustomButton(
              text: 'Login',
              onPressed: () {},
              isPrimary: false,
              width: 90,
              height: 38,
            ),
            const SizedBox(width: 10),
            CustomButton(
              text: 'Register',
              onPressed: () {},
              width: 110,
              height: 38,
            ),
          ] else
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.primaryBlue),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          onTap: onTap,
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
