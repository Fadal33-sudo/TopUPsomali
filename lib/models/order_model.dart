import 'game_model.dart';

enum OrderStatus {
  pending,
  completed,
  failed,
}

class OrderModel {
  final String id;
  final String userId;
  final String playerId;
  final Game game;
  final TopUpPackage package;
  final String paymentMethod;
  final DateTime date;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.userId,
    required this.playerId,
    required this.game,
    required this.package,
    required this.paymentMethod,
    required this.date,
    required this.status,
  });
}
