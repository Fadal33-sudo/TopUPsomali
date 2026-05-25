import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_page.dart';
import '../screens/game_topup_page.dart';
import '../screens/checkout_page.dart';
import '../screens/success_page.dart';
import '../screens/profile_page.dart';
import '../screens/orders_page.dart';
import '../admin/admin_dashboard.dart';
import '../models/game_model.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/game/:id',
        builder: (context, state) {
          final gameId = state.pathParameters['id']!;
          return GameTopUpPage(gameId: gameId);
        },
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        path: '/success',
        builder: (context, state) => const SuccessPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersPage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboard(),
      ),
    ],
  );
}
