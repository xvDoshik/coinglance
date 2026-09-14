class CoinRate {
  const CoinRate({
    required this.coinId,
    required this.displayName,
    required this.symbol,
    required this.quote,
    required this.price,
    required this.change24h,
    required this.fetchedAt,
  });

  final String coinId;
  final String displayName;
  final String symbol;
  final String quote;
  final double price;
  final double? change24h;
  final DateTime fetchedAt;

  bool get isStale {
    return DateTime.now().difference(fetchedAt) > const Duration(minutes: 5);
  }

  CoinRate copyWith({
    double? price,
    double? change24h,
    DateTime? fetchedAt,
    String? quote,
  }) {
    return CoinRate(
      coinId: coinId,
      displayName: displayName,
      symbol: symbol,
      quote: quote ?? this.quote,
      price: price ?? this.price,
      change24h: change24h ?? this.change24h,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}

const trackedCoins = [
  (id: 'bitcoin', name: 'Bitcoin', symbol: 'BTC'),
  (id: 'toncoin', name: 'Toncoin', symbol: 'TON'),
];
