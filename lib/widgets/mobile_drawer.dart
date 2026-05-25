import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: AppColors.grayBorder)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.flash_on, color: AppColors.primaryBlue, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    AppConstants.appName,
                    style: const TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _drawerItem(Icons.home_outlined, 'Home', () => context.go('/')),
          _drawerItem(Icons.sports_esports_outlined, 'PUBG Mobile', () => context.go('/game/pubg')),
          _drawerItem(Icons.diamond_outlined, 'Free Fire', () => context.go('/game/freefire')),
          _drawerItem(Icons.sports_soccer_outlined, 'eFootball', () => context.go('/game/efootball')),
          const Divider(),
          _drawerItem(Icons.person_outline, 'Profile', () => context.go('/profile')),
          _drawerItem(Icons.shopping_bag_outlined, 'My Orders', () => context.go('/orders')),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryBlue),
                      foregroundColor: AppColors.primaryBlue,
                    ),
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textDark),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.textDark),
      ),
      onTap: onTap,
    );
  }
}
