import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import '../widgets/custom_button.dart';
import '../widgets/mobile_drawer.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

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
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _summaryRow('Game', 'PUBG Mobile'),
                          const Divider(height: 30),
                          _summaryRow('Package', '325 UC'),
                          const Divider(height: 30),
                          _summaryRow('Player ID', '512345678'),
                          const Divider(height: 30),
                          _summaryRow('Payment Method', 'EVC Plus'),
                          const Divider(height: 30),
                          _summaryRow('Total Price', '\$4.99', isTotal: true),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Confirm and Pay',
                    onPressed: () => context.go('/success'),
                    width: double.infinity,
                    height: 55,
                  ),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.textDark : AppColors.textGray,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: isTotal ? 24 : 16,
              fontWeight: FontWeight.bold,
              color: isTotal ? AppColors.primaryBlue : AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
