// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $BalanceTableTable extends BalanceTable
    with TableInfo<$BalanceTableTable, BalanceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BalanceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'balance_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BalanceTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BalanceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BalanceTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $BalanceTableTable createAlias(String alias) {
    return $BalanceTableTable(attachedDatabase, alias);
  }
}

class BalanceTableData extends DataClass
    implements Insertable<BalanceTableData> {
  final int id;
  final double amount;
  const BalanceTableData({required this.id, required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  BalanceTableCompanion toCompanion(bool nullToAbsent) {
    return BalanceTableCompanion(id: Value(id), amount: Value(amount));
  }

  factory BalanceTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BalanceTableData(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
    };
  }

  BalanceTableData copyWith({int? id, double? amount}) =>
      BalanceTableData(id: id ?? this.id, amount: amount ?? this.amount);
  BalanceTableData copyWithCompanion(BalanceTableCompanion data) {
    return BalanceTableData(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BalanceTableData(')
          ..write('id: $id, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BalanceTableData &&
          other.id == this.id &&
          other.amount == this.amount);
}

class BalanceTableCompanion extends UpdateCompanion<BalanceTableData> {
  final Value<int> id;
  final Value<double> amount;
  const BalanceTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
  });
  BalanceTableCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
  }) : amount = Value(amount);
  static Insertable<BalanceTableData> custom({
    Expression<int>? id,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
    });
  }

  BalanceTableCompanion copyWith({Value<int>? id, Value<double>? amount}) {
    return BalanceTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalanceTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, description, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }
}

class TransactionsTableData extends DataClass
    implements Insertable<TransactionsTableData> {
  final int id;
  final DateTime date;
  final String description;
  final double amount;
  const TransactionsTableData({
    required this.id,
    required this.date,
    required this.description,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      date: Value(date),
      description: Value(description),
      amount: Value(amount),
    );
  }

  factory TransactionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsTableData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<double>(amount),
    };
  }

  TransactionsTableData copyWith({
    int? id,
    DateTime? date,
    String? description,
    double? amount,
  }) => TransactionsTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    description: description ?? this.description,
    amount: amount ?? this.amount,
  );
  TransactionsTableData copyWithCompanion(TransactionsTableCompanion data) {
    return TransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, description, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.description == this.description &&
          other.amount == this.amount);
}

class TransactionsTableCompanion
    extends UpdateCompanion<TransactionsTableData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<double> amount;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String description,
    required double amount,
  }) : date = Value(date),
       description = Value(description),
       amount = Value(amount);
  static Insertable<TransactionsTableData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
    });
  }

  TransactionsTableCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? description,
    Value<double>? amount,
  }) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      description: description ?? this.description,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BalanceTableTable balanceTable = $BalanceTableTable(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    balanceTable,
    transactionsTable,
  ];
}

typedef $$BalanceTableTableCreateCompanionBuilder =
    BalanceTableCompanion Function({Value<int> id, required double amount});
typedef $$BalanceTableTableUpdateCompanionBuilder =
    BalanceTableCompanion Function({Value<int> id, Value<double> amount});

class $$BalanceTableTableFilterComposer
    extends Composer<_$AppDatabase, $BalanceTableTable> {
  $$BalanceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BalanceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BalanceTableTable> {
  $$BalanceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BalanceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BalanceTableTable> {
  $$BalanceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$BalanceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BalanceTableTable,
          BalanceTableData,
          $$BalanceTableTableFilterComposer,
          $$BalanceTableTableOrderingComposer,
          $$BalanceTableTableAnnotationComposer,
          $$BalanceTableTableCreateCompanionBuilder,
          $$BalanceTableTableUpdateCompanionBuilder,
          (
            BalanceTableData,
            BaseReferences<_$AppDatabase, $BalanceTableTable, BalanceTableData>,
          ),
          BalanceTableData,
          PrefetchHooks Function()
        > {
  $$BalanceTableTableTableManager(_$AppDatabase db, $BalanceTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BalanceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BalanceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BalanceTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
              }) => BalanceTableCompanion(id: id, amount: amount),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double amount,
              }) => BalanceTableCompanion.insert(id: id, amount: amount),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BalanceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BalanceTableTable,
      BalanceTableData,
      $$BalanceTableTableFilterComposer,
      $$BalanceTableTableOrderingComposer,
      $$BalanceTableTableAnnotationComposer,
      $$BalanceTableTableCreateCompanionBuilder,
      $$BalanceTableTableUpdateCompanionBuilder,
      (
        BalanceTableData,
        BaseReferences<_$AppDatabase, $BalanceTableTable, BalanceTableData>,
      ),
      BalanceTableData,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableTableCreateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<int> id,
      required DateTime date,
      required String description,
      required double amount,
    });
typedef $$TransactionsTableTableUpdateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> description,
      Value<double> amount,
    });

class $$TransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$TransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData,
          $$TransactionsTableTableFilterComposer,
          $$TransactionsTableTableOrderingComposer,
          $$TransactionsTableTableAnnotationComposer,
          $$TransactionsTableTableCreateCompanionBuilder,
          $$TransactionsTableTableUpdateCompanionBuilder,
          (
            TransactionsTableData,
            BaseReferences<
              _$AppDatabase,
              $TransactionsTableTable,
              TransactionsTableData
            >,
          ),
          TransactionsTableData,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableTableManager(
    _$AppDatabase db,
    $TransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> amount = const Value.absent(),
              }) => TransactionsTableCompanion(
                id: id,
                date: date,
                description: description,
                amount: amount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String description,
                required double amount,
              }) => TransactionsTableCompanion.insert(
                id: id,
                date: date,
                description: description,
                amount: amount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTableTable,
      TransactionsTableData,
      $$TransactionsTableTableFilterComposer,
      $$TransactionsTableTableOrderingComposer,
      $$TransactionsTableTableAnnotationComposer,
      $$TransactionsTableTableCreateCompanionBuilder,
      $$TransactionsTableTableUpdateCompanionBuilder,
      (
        TransactionsTableData,
        BaseReferences<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData
        >,
      ),
      TransactionsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BalanceTableTableTableManager get balanceTable =>
      $$BalanceTableTableTableManager(_db, _db.balanceTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(_db, _db.transactionsTable);
}
