import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import '../widgets/mobile_drawer.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const AppHeader(),
        endDrawer: isMobile ? const MobileDrawer() : null,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                constraints:
                    const BoxConstraints(maxWidth: AppConstants.maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Orders',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const TabBar(
                      labelColor: AppColors.primaryBlue,
                      unselectedLabelColor: AppColors.textGray,
                      indicatorColor: AppColors.primaryBlue,
                      tabs: [
                        Tab(text: 'Pending'),
                        Tab(text: 'Completed'),
                        Tab(text: 'Failed'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 500,
                      child: TabBarView(
                        children: [
                          _buildOrderList('Pending'),
                          _buildOrderList('Completed'),
                          _buildOrderList('Failed'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const AppFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return ListView.builder(
      itemCount: status == 'Completed' ? 3 : 0,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_S-G5W1_m8hG2r2_e7Yv_Pz6_y_H5z-f-vg&s'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text('PUBG Mobile - 325 UC',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Date: 25 May 2026 • ID: #VEXO-98234'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: status == 'Completed'
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: status == 'Completed' ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
