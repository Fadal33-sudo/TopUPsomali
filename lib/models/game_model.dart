enum GameCategory {
  pubg,
  freefire,
  efootball,
  mobileLegends,
  cod,
  primePlus,
}

class Game {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final GameCategory category;
  final String bannerUrl;

  Game({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.bannerUrl,
  });
}

class TopUpPackage {
  final String id;
  final String name;
  final double price;
  final String amount;
  final String? bonus;

  TopUpPackage({
    required this.id,
    required this.name,
    required this.price,
    required this.amount,
    this.bonus,
  });
}
