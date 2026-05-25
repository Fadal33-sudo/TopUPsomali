import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../core/constants.dart';
import '../core/mock_data.dart';
import '../models/game_model.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import '../widgets/custom_button.dart';
import '../widgets/mobile_drawer.dart';

class GameTopUpPage extends StatefulWidget {
  final String gameId;
  const GameTopUpPage({super.key, required this.gameId});

  @override
  State<GameTopUpPage> createState() => _GameTopUpPageState();
}

class _GameTopUpPageState extends State<GameTopUpPage> {
  TopUpPackage? selectedPackage;
  String? selectedPayment;
  final TextEditingController playerIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final game = MockData.games.firstWhere((g) => g.id == widget.gameId);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      appBar: const AppHeader(),
      endDrawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBanner(game),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 20 : 40,
                horizontal: isMobile ? 12 : 20,
              ),
              constraints:
                  const BoxConstraints(maxWidth: AppConstants.maxWidth),
              child: isMobile
                  ? Column(
                      children: [
                        _buildPackageList(isMobile),
                        const SizedBox(height: 25),
                        _buildPurchaseForm(game, isMobile),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildPackageList(isMobile)),
                        const SizedBox(width: 40),
                        Expanded(
                            flex: 1, child: _buildPurchaseForm(game, isMobile)),
                      ],
                    ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(Game game) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      height: isMobile ? 180 : 250,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(game.bannerUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        padding: EdgeInsets.all(isMobile ? 20 : 40),
        alignment: Alignment.bottomLeft,
        child: Text(
          game.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPackageList(bool isMobile) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    // Force 2 columns for Mobile and Tablet for better fit
    int crossAxisCount = isDesktop ? 4 : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '1. Select Package',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isDesktop ? 15 : 10,
            mainAxisSpacing: isDesktop ? 15 : 10,
            childAspectRatio: isDesktop ? 1.5 : 1.3,
          ),
          itemCount: MockData.pubgPackages.length,
          itemBuilder: (context, index) {
            final package = MockData.pubgPackages[index];
            final isSelected = selectedPackage?.id == package.id;
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(
                onTap: () => setState(() => selectedPackage = package),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryBlue.withOpacity(0.05)
                        : Colors.white,
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlue
                          : AppColors.grayBorder,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        package.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 14 : 16,
                          color: isSelected
                              ? AppColors.primaryBlue
                              : AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$${package.price}',
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : AppColors.textGray,
                          fontSize: isMobile ? 12 : 14,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (package.bonus != null) ...[
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            package.bonus!,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: isMobile ? 9 : 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPurchaseForm(Game game, bool isMobile) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2. Enter Player ID',
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: playerIdController,
              style: TextStyle(fontSize: isMobile ? 14 : 16),
              decoration: const InputDecoration(
                hintText: 'Enter Player ID',
                prefixIcon: Icon(Icons.person_outline, size: 20),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              '3. Select Payment',
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _paymentOption('EVC Plus', isMobile),
            _paymentOption('Zaad', isMobile),
            _paymentOption('eDahab', isMobile),
            const SizedBox(height: 25),
            if (selectedPackage != null) ...[
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Selected:',
                      style: TextStyle(fontSize: isMobile ? 13 : 14)),
                  Text(selectedPackage!.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 13 : 14)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price:',
                      style: TextStyle(fontSize: isMobile ? 13 : 14)),
                  Text('\$${selectedPackage!.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 16 : 18,
                          color: AppColors.primaryBlue)),
                ],
              ),
              const SizedBox(height: 15),
            ],
            CustomButton(
              text: 'Confirm Order',
              onPressed: () {
                if (selectedPackage != null &&
                    playerIdController.text.isNotEmpty &&
                    selectedPayment != null) {
                  context.go('/checkout');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please complete all fields')),
                  );
                }
              },
              width: double.infinity,
              height: isMobile ? 45 : 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(String method, bool isMobile) {
    final isSelected = selectedPayment == method;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => setState(() => selectedPayment = method),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 10 : 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primaryBlue : AppColors.grayBorder,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? AppColors.primaryBlue : AppColors.textGray,
                size: isMobile ? 18 : 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  method,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
