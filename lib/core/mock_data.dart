import '../models/game_model.dart';

class MockData {
  static List<Game> games = [
    Game(
      id: 'pubg',
      name: 'PUBG Mobile',
      imageUrl:
          'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=300&fit=crop',
      description: 'Top Up UC',
      category: GameCategory.pubg,
      bannerUrl:
          'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=1200&h=400&fit=crop',
    ),
    Game(
      id: 'freefire',
      name: 'Free Fire',
      imageUrl:
          'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400&h=300&fit=crop',
      description: 'Top Up Diamonds',
      category: GameCategory.freefire,
      bannerUrl:
          'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=1200&h=400&fit=crop',
    ),
    Game(
      id: 'efootball',
      name: 'eFootball',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400&h=300&fit=crop',
      description: 'Top Up Coins',
      category: GameCategory.efootball,
      bannerUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=1200&h=400&fit=crop',
    ),
  ];

  static List<TopUpPackage> pubgPackages = [
    TopUpPackage(
        id: 'p1', name: '60 UC', price: 0.99, amount: '60', bonus: '+ Bonus'),
    TopUpPackage(
        id: 'p2', name: '325 UC', price: 4.99, amount: '325', bonus: '+ Bonus'),
    TopUpPackage(
        id: 'p3', name: '660 UC', price: 9.99, amount: '660', bonus: '+ Bonus'),
    TopUpPackage(
        id: 'p4',
        name: '1800 UC',
        price: 24.99,
        amount: '1800',
        bonus: '+ Bonus'),
    TopUpPackage(
        id: 'p5',
        name: '3850 UC',
        price: 49.99,
        amount: '3850',
        bonus: '+ Bonus'),
    TopUpPackage(
        id: 'p6',
        name: '8100 UC',
        price: 99.99,
        amount: '8100',
        bonus: '+ Bonus'),
  ];
}
