// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RatesTable extends Rates with TableInfo<$RatesTable, Rate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _coinIdMeta = const VerificationMeta('coinId');
  @override
  late final GeneratedColumn<String> coinId = GeneratedColumn<String>(
    'coin_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteMeta = const VerificationMeta('quote');
  @override
  late final GeneratedColumn<String> quote = GeneratedColumn<String>(
    'quote',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _change24hMeta = const VerificationMeta(
    'change24h',
  );
  @override
  late final GeneratedColumn<double> change24h = GeneratedColumn<double>(
    'change24h',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    coinId,
    quote,
    price,
    change24h,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<Rate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('coin_id')) {
      context.handle(
        _coinIdMeta,
        coinId.isAcceptableOrUnknown(data['coin_id']!, _coinIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coinIdMeta);
    }
    if (data.containsKey('quote')) {
      context.handle(
        _quoteMeta,
        quote.isAcceptableOrUnknown(data['quote']!, _quoteMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('change24h')) {
      context.handle(
        _change24hMeta,
        change24h.isAcceptableOrUnknown(data['change24h']!, _change24hMeta),
      );
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {coinId, quote};
  @override
  Rate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rate(
      coinId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coin_id'],
      )!,
      quote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      change24h: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}change24h'],
      ),
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $RatesTable createAlias(String alias) {
    return $RatesTable(attachedDatabase, alias);
  }
}

class Rate extends DataClass implements Insertable<Rate> {
  final String coinId;
  final String quote;
  final double price;
  final double? change24h;
  final DateTime fetchedAt;
  const Rate({
    required this.coinId,
    required this.quote,
    required this.price,
    this.change24h,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['coin_id'] = Variable<String>(coinId);
    map['quote'] = Variable<String>(quote);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || change24h != null) {
      map['change24h'] = Variable<double>(change24h);
    }
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  RatesCompanion toCompanion(bool nullToAbsent) {
    return RatesCompanion(
      coinId: Value(coinId),
      quote: Value(quote),
      price: Value(price),
      change24h: change24h == null && nullToAbsent
          ? const Value.absent()
          : Value(change24h),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory Rate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rate(
      coinId: serializer.fromJson<String>(json['coinId']),
      quote: serializer.fromJson<String>(json['quote']),
      price: serializer.fromJson<double>(json['price']),
      change24h: serializer.fromJson<double?>(json['change24h']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'coinId': serializer.toJson<String>(coinId),
      'quote': serializer.toJson<String>(quote),
      'price': serializer.toJson<double>(price),
      'change24h': serializer.toJson<double?>(change24h),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  Rate copyWith({
    String? coinId,
    String? quote,
    double? price,
    Value<double?> change24h = const Value.absent(),
    DateTime? fetchedAt,
  }) => Rate(
    coinId: coinId ?? this.coinId,
    quote: quote ?? this.quote,
    price: price ?? this.price,
    change24h: change24h.present ? change24h.value : this.change24h,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  Rate copyWithCompanion(RatesCompanion data) {
    return Rate(
      coinId: data.coinId.present ? data.coinId.value : this.coinId,
      quote: data.quote.present ? data.quote.value : this.quote,
      price: data.price.present ? data.price.value : this.price,
      change24h: data.change24h.present ? data.change24h.value : this.change24h,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Rate(')
          ..write('coinId: $coinId, ')
          ..write('quote: $quote, ')
          ..write('price: $price, ')
          ..write('change24h: $change24h, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(coinId, quote, price, change24h, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rate &&
          other.coinId == this.coinId &&
          other.quote == this.quote &&
          other.price == this.price &&
          other.change24h == this.change24h &&
          other.fetchedAt == this.fetchedAt);
}

class RatesCompanion extends UpdateCompanion<Rate> {
  final Value<String> coinId;
  final Value<String> quote;
  final Value<double> price;
  final Value<double?> change24h;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const RatesCompanion({
    this.coinId = const Value.absent(),
    this.quote = const Value.absent(),
    this.price = const Value.absent(),
    this.change24h = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RatesCompanion.insert({
    required String coinId,
    required String quote,
    required double price,
    this.change24h = const Value.absent(),
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : coinId = Value(coinId),
       quote = Value(quote),
       price = Value(price),
       fetchedAt = Value(fetchedAt);
  static Insertable<Rate> custom({
    Expression<String>? coinId,
    Expression<String>? quote,
    Expression<double>? price,
    Expression<double>? change24h,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (coinId != null) 'coin_id': coinId,
      if (quote != null) 'quote': quote,
      if (price != null) 'price': price,
      if (change24h != null) 'change24h': change24h,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RatesCompanion copyWith({
    Value<String>? coinId,
    Value<String>? quote,
    Value<double>? price,
    Value<double?>? change24h,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return RatesCompanion(
      coinId: coinId ?? this.coinId,
      quote: quote ?? this.quote,
      price: price ?? this.price,
      change24h: change24h ?? this.change24h,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (coinId.present) {
      map['coin_id'] = Variable<String>(coinId.value);
    }
    if (quote.present) {
      map['quote'] = Variable<String>(quote.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (change24h.present) {
      map['change24h'] = Variable<double>(change24h.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RatesCompanion(')
          ..write('coinId: $coinId, ')
          ..write('quote: $quote, ')
          ..write('price: $price, ')
          ..write('change24h: $change24h, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RatesTable rates = $RatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [rates];
}

typedef $$RatesTableCreateCompanionBuilder =
    RatesCompanion Function({
      required String coinId,
      required String quote,
      required double price,
      Value<double?> change24h,
      required DateTime fetchedAt,
      Value<int> rowid,
    });
typedef $$RatesTableUpdateCompanionBuilder =
    RatesCompanion Function({
      Value<String> coinId,
      Value<String> quote,
      Value<double> price,
      Value<double?> change24h,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

class $$RatesTableFilterComposer extends Composer<_$AppDatabase, $RatesTable> {
  $$RatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get coinId => $composableBuilder(
    column: $table.coinId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get change24h => $composableBuilder(
    column: $table.change24h,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RatesTableOrderingComposer
    extends Composer<_$AppDatabase, $RatesTable> {
  $$RatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get coinId => $composableBuilder(
    column: $table.coinId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get change24h => $composableBuilder(
    column: $table.change24h,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RatesTable> {
  $$RatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get coinId =>
      $composableBuilder(column: $table.coinId, builder: (column) => column);

  GeneratedColumn<String> get quote =>
      $composableBuilder(column: $table.quote, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get change24h =>
      $composableBuilder(column: $table.change24h, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$RatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RatesTable,
          Rate,
          $$RatesTableFilterComposer,
          $$RatesTableOrderingComposer,
          $$RatesTableAnnotationComposer,
          $$RatesTableCreateCompanionBuilder,
          $$RatesTableUpdateCompanionBuilder,
          (Rate, BaseReferences<_$AppDatabase, $RatesTable, Rate>),
          Rate,
          PrefetchHooks Function()
        > {
  $$RatesTableTableManager(_$AppDatabase db, $RatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> coinId = const Value.absent(),
                Value<String> quote = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> change24h = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RatesCompanion(
                coinId: coinId,
                quote: quote,
                price: price,
                change24h: change24h,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String coinId,
                required String quote,
                required double price,
                Value<double?> change24h = const Value.absent(),
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => RatesCompanion.insert(
                coinId: coinId,
                quote: quote,
                price: price,
                change24h: change24h,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RatesTable,
      Rate,
      $$RatesTableFilterComposer,
      $$RatesTableOrderingComposer,
      $$RatesTableAnnotationComposer,
      $$RatesTableCreateCompanionBuilder,
      $$RatesTableUpdateCompanionBuilder,
      (Rate, BaseReferences<_$AppDatabase, $RatesTable, Rate>),
      Rate,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RatesTableTableManager get rates =>
      $$RatesTableTableManager(_db, _db.rates);
}
