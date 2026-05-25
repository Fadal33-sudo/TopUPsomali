import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';
import '../widgets/custom_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.success,
                size: 100,
              ),
              const SizedBox(height: 30),
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Your order has been processed successfully. The UC will be added to your account shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGray, fontSize: 16),
              ),
              const SizedBox(height: 40),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _orderDetail('Order ID', '#VEXO-98234'),
                      const SizedBox(height: 10),
                      _orderDetail('Game', 'PUBG Mobile'),
                      const SizedBox(height: 10),
                      _orderDetail('Package', '325 UC'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Continue Shopping',
                onPressed: () => context.go('/'),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textGray)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
