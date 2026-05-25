import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../core/constants.dart';
import '../core/mock_data.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import '../widgets/game_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/mobile_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCarouselIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      appBar: const AppHeader(),
      endDrawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildFeaturedGames(context),
            _buildWhyChooseUs(context),
            _buildPaymentMethods(context),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
          child: Column(
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: isMobile ? 200 : 400,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                ),
                items: MockData.games.map((game) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () => context.go('/game/${game.id}'),
                        child: Container(
                          width: screenWidth,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(game.bannerUrl),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        game.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isMobile ? 24 : 42,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              offset: const Offset(0, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Top Up Now & Save More',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: isMobile ? 14 : 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      if (!isMobile)
                                        CustomButton(
                                          text: 'Shop Now',
                                          onPressed: () =>
                                              context.go('/game/${game.id}'),
                                          width: 160,
                                          height: 45,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: MockData.games.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: Container(
                      width: _currentCarouselIndex == entry.key ? 24.0 : 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.primaryBlue.withOpacity(
                          _currentCarouselIndex == entry.key ? 1.0 : 0.3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedGames(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    int crossAxisCount = 4;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Games',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                    color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 1.5 : (isTablet ? 0.85 : 0.8),
            ),
            itemCount: MockData.games.length,
            itemBuilder: (context, index) {
              final game = MockData.games[index];
              return GameCard(
                game: game,
                onTap: () => context.go('/game/${game.id}'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUs(BuildContext context) {
    return Container(
      color: AppColors.cardBackground,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Why Choose VEXO TOPUP',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _featureItem(Icons.flash_on, 'Instant Delivery',
                  'Your top up is delivered in seconds'),
              _featureItem(Icons.security, 'Secure Payment',
                  '100% secure payment methods'),
              _featureItem(Icons.headset_mic, '24/7 Support',
                  'We are here to help you anytime'),
              _featureItem(
                  Icons.star, 'Best Prices', 'Affordable gaming top ups'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _featureItem(IconData icon, String title, String desc) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textGray),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(BuildContext context) {
    final methods = [
      'EVC Plus',
      'Zaad',
      'Sahal',
      'eDahab',
      'Visa',
      'MasterCard'
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Payment Methods',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: methods
                  .map((m) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grayBorder),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Text(m,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
