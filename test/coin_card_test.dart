import 'package:coinglance/domain/coin_rate.dart';
import 'package:coinglance/features/rates/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CoinCard shows symbol and price', (tester) async {
    final rate = CoinRate(
      coinId: 'bitcoin',
      displayName: 'Bitcoin',
      symbol: 'BTC',
      quote: 'usd',
      price: 42000,
      change24h: 2.5,
      fetchedAt: DateTime(2026, 1, 1, 12, 0),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CoinCard(rate: rate)),
      ),
    );

    expect(find.text('BTC'), findsOneWidget);
    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.textContaining('42'), findsOneWidget);
  });
}
