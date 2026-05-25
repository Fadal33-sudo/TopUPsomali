import 'package:flutter/material.dart';
import '../core/constants.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: AppColors.textDark,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'VEXO ADMIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                _sidebarItem(Icons.dashboard, 'Dashboard', true),
                _sidebarItem(Icons.shopping_cart, 'Orders', false),
                _sidebarItem(Icons.people, 'Users', false),
                _sidebarItem(Icons.games, 'Games', false),
                _sidebarItem(Icons.inventory, 'Packages', false),
                _sidebarItem(Icons.analytics, 'Analytics', false),
                const Spacer(),
                _sidebarItem(Icons.logout, 'Logout', false),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Container(
              color: AppColors.cardBackground,
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Admin Dashboard',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      _statCard('Total Revenue', '\$12,450', Icons.attach_money,
                          Colors.green),
                      _statCard('Total Orders', '1,240', Icons.shopping_bag,
                          Colors.blue),
                      _statCard(
                          'Total Users', '850', Icons.people, Colors.orange),
                      _statCard('Success Rate', '98%', Icons.trending_up,
                          Colors.purple),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Recent Orders',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(child: Text('U')),
                            title: const Text('User ID: #512345678'),
                            subtitle: const Text('PUBG Mobile - 325 UC'),
                            trailing: const Text('\$4.99',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String title, bool isSelected) {
    return Container(
      color: isSelected ? AppColors.primaryBlue : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        onTap: () {},
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(right: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 15),
              Text(title, style: const TextStyle(color: AppColors.textGray)),
              const SizedBox(height: 5),
              Text(value,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
