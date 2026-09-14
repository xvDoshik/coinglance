import 'package:coinglance/core/dio_client.dart';
import 'package:coinglance/data/coingecko_datasource.dart';
import 'package:coinglance/data/database.dart';
import 'package:coinglance/data/rates_repository.dart';
import 'package:coinglance/domain/coin_rate.dart';
import 'package:coinglance/features/widget_bridge/widget_sync.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final dioProvider = Provider((ref) => createDio());

final coingeckoProvider = Provider(
  (ref) => CoingeckoDatasource(ref.watch(dioProvider)),
);

final ratesRepositoryProvider = Provider(
  (ref) => RatesRepository(ref.watch(databaseProvider), ref.watch(coingeckoProvider)),
);

final quoteCurrencyProvider = StateNotifierProvider<QuoteCurrencyNotifier, String>(
  (ref) => QuoteCurrencyNotifier(),
);

class QuoteCurrencyNotifier extends StateNotifier<String> {
  QuoteCurrencyNotifier() : super('usd') {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('quote_currency') ?? 'usd';
  }

  Future<void> setQuote(String quote) async {
    state = quote;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('quote_currency', quote);
  }
}

final ratesControllerProvider =
    AsyncNotifierProvider<RatesController, List<CoinRate>>(RatesController.new);

class RatesController extends AsyncNotifier<List<CoinRate>> {
  @override
  Future<List<CoinRate>> build() async {
    await WidgetSync.configure();
    final quote = ref.watch(quoteCurrencyProvider);
    final repo = ref.watch(ratesRepositoryProvider);
    final rates = await repo.loadOrRefresh(quote);
    await WidgetSync.pushRates(rates);
    return rates;
  }

  Future<void> refresh({bool force = true}) async {
    final quote = ref.read(quoteCurrencyProvider);
    final repo = ref.read(ratesRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final rates = force ? await repo.refresh(quote) : await repo.loadOrRefresh(quote);
      await WidgetSync.pushRates(rates);
      return rates;
    });
  }
}
