import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import '../widgets/mobile_drawer.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      appBar: const AppHeader(),
      endDrawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primaryBlue,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Barkhad Abdullahi',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text('barkhad@example.com',
                      style: TextStyle(color: AppColors.textGray)),
                  const SizedBox(height: 40),
                  _buildProfileMenu(context),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Column(
      children: [
        _menuItem(
            Icons.account_balance_wallet, 'Wallet Balance', '\$120.50', () {}),
        _menuItem(
            Icons.shopping_bag, 'My Orders', null, () => context.go('/orders')),
        _menuItem(Icons.history, 'Transactions', null, () {}),
        _menuItem(Icons.settings, 'Settings', null, () {}),
        const SizedBox(height: 20),
        _menuItem(Icons.logout, 'Logout', null, () {}, isDestructive: true),
      ],
    );
  }

  Widget _menuItem(
      IconData icon, String title, String? trailing, VoidCallback onTap,
      {bool isDestructive = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon,
            color: isDestructive ? Colors.red : AppColors.primaryBlue),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDestructive ? Colors.red : AppColors.textDark,
          ),
        ),
        trailing: trailing != null
            ? Text(trailing,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primaryBlue))
            : const Icon(Icons.chevron_right),
      ),
    );
  }
}
