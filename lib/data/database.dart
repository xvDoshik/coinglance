import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Rates extends Table {
  TextColumn get coinId => text()();
  TextColumn get quote => text()();
  RealColumn get price => real()();
  RealColumn get change24h => real().nullable()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {coinId, quote};
}

@DriftDatabase(tables: [Rates])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> upsertRate({
    required String coinId,
    required String quote,
    required double price,
    double? change24h,
    required DateTime fetchedAt,
  }) async {
    await into(rates).insertOnConflictUpdate(
      RatesCompanion.insert(
        coinId: coinId,
        quote: quote,
        price: price,
        change24h: Value(change24h),
        fetchedAt: fetchedAt,
      ),
    );
  }

  Future<List<Rate>> ratesForQuote(String quote) {
    return (select(rates)..where((r) => r.quote.equals(quote))).get();
  }

  Future<Rate?> rateFor(String coinId, String quote) {
    return (select(rates)
          ..where((r) => r.coinId.equals(coinId) & r.quote.equals(quote)))
        .getSingleOrNull();
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'coinglance');
}
