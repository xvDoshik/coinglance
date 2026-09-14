import 'dart:convert';

import 'package:coinglance/domain/coin_rate.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';

const widgetGroupId = 'group.com.coinglance.widget';
const androidWidgetProvider = 'com.coinglance.coinglance.CoinGlanceWidgetProvider';
const iosWidgetName = 'CoinGlanceWidget';

class WidgetSync {
  static Future<void> configure() async {
    await HomeWidget.setAppGroupId(widgetGroupId);
  }

  static Future<void> pushRates(List<CoinRate> rates) async {
    final payload = rates
        .where((r) => r.fetchedAt.millisecondsSinceEpoch > 0)
        .map(
          (r) => {
            'id': r.coinId,
            'symbol': r.symbol,
            'name': r.displayName,
            'quote': r.quote,
            'price': r.price,
            'change24h': r.change24h,
            'fetchedAt': r.fetchedAt.toIso8601String(),
          },
        )
        .toList();
    if (payload.isEmpty) return;

    final quote = rates.first.quote.toUpperCase();
    final fmt = NumberFormat.currency(name: quote, symbol: _symbolFor(quote));
    final lines = payload.map((m) {
      final price = m['price'] as double;
      final change = m['change24h'] as double?;
      final sym = m['symbol'] as String;
      final changeText = change == null ? '' : ' ${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%';
      return '$sym ${fmt.format(price)}$changeText';
    }).join('\n');

    await HomeWidget.saveWidgetData<String>('rates_json', jsonEncode(payload));
    await HomeWidget.saveWidgetData<String>('rates_lines', lines);
    await HomeWidget.updateWidget(
      name: androidWidgetProvider,
      iOSName: iosWidgetName,
    );
  }

  static String _symbolFor(String quote) {
    switch (quote) {
      case 'USD':
        return r'$';
      case 'EUR':
        return '€';
      default:
        return quote;
    }
  }
}
