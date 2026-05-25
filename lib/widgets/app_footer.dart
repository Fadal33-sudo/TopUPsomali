import 'package:flutter/material.dart';
import '../core/constants.dart';

import 'package:responsive_framework/responsive_framework.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  Widget _buildFooterContent(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          _footerSection(
              'VEXO TOPUP', ['About Us', 'Contact Us', 'Terms', 'Privacy'],
              isMobile: true),
          const SizedBox(height: 30),
          _footerSection('GAMES', ['PUBG', 'Free Fire', 'eFootball', 'MLBB'],
              isMobile: true),
          const SizedBox(height: 30),
          _footerSection(
              'SUPPORT', ['Help', 'How to Top Up', 'Payments', 'FAQ'],
              isMobile: true),
        ],
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: _footerSection(
                'VEXO TOPUP',
                [
                  'About Us',
                  'Contact Us',
                  'Terms of Service',
                  'Privacy Policy'
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: _footerSection(
                'GAMES',
                ['PUBG Mobile', 'Free Fire', 'eFootball', 'Mobile Legends'],
              ),
            ),
            SizedBox(
              width: 200,
              child: _footerSection(
                'SUPPORT',
                ['Help Center', 'How to Top Up', 'Payment Methods', 'FAQ'],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: AppColors.cardBackground,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          _buildFooterContent(context, isMobile),
          const SizedBox(height: 40),
          const Divider(color: AppColors.grayBorder),
          const SizedBox(height: 20),
          const Text(
            '© 2026 VEXO TOPUP. All rights reserved.',
            style: TextStyle(color: AppColors.textGray, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _footerSection(String title, List<String> items,
      {bool isMobile = false}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 15),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                item,
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: const TextStyle(color: AppColors.textGray, fontSize: 14),
              ),
            )),
      ],
    );
  }
}
