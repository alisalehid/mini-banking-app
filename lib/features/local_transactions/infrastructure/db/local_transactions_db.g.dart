// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_transactions_db.dart';

// ignore_for_file: type=lint
class $BalancesTable extends Balances with TableInfo<$BalancesTable, Balance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BalancesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, amountCents];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'balances';
  @override
  VerificationContext validateIntegrity(
    Insertable<Balance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Balance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Balance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
    );
  }

  @override
  $BalancesTable createAlias(String alias) {
    return $BalancesTable(attachedDatabase, alias);
  }
}

class Balance extends DataClass implements Insertable<Balance> {
  final int id;
  final int amountCents;
  const Balance({required this.id, required this.amountCents});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount_cents'] = Variable<int>(amountCents);
    return map;
  }

  BalancesCompanion toCompanion(bool nullToAbsent) {
    return BalancesCompanion(id: Value(id), amountCents: Value(amountCents));
  }

  factory Balance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Balance(
      id: serializer.fromJson<int>(json['id']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amountCents': serializer.toJson<int>(amountCents),
    };
  }

  Balance copyWith({int? id, int? amountCents}) =>
      Balance(id: id ?? this.id, amountCents: amountCents ?? this.amountCents);
  Balance copyWithCompanion(BalancesCompanion data) {
    return Balance(
      id: data.id.present ? data.id.value : this.id,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Balance(')
          ..write('id: $id, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amountCents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Balance &&
          other.id == this.id &&
          other.amountCents == this.amountCents);
}

class BalancesCompanion extends UpdateCompanion<Balance> {
  final Value<int> id;
  final Value<int> amountCents;
  const BalancesCompanion({
    this.id = const Value.absent(),
    this.amountCents = const Value.absent(),
  });
  BalancesCompanion.insert({
    this.id = const Value.absent(),
    this.amountCents = const Value.absent(),
  });
  static Insertable<Balance> custom({
    Expression<int>? id,
    Expression<int>? amountCents,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amountCents != null) 'amount_cents': amountCents,
    });
  }

  BalancesCompanion copyWith({Value<int>? id, Value<int>? amountCents}) {
    return BalancesCompanion(
      id: id ?? this.id,
      amountCents: amountCents ?? this.amountCents,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalancesCompanion(')
          ..write('id: $id, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }
}

class $LocalTxnsTable extends LocalTxns
    with TableInfo<$LocalTxnsTable, LocalTxn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalTxnsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, description, amountCents];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_txns';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalTxn> instance, {
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
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalTxn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTxn(
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
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
    );
  }

  @override
  $LocalTxnsTable createAlias(String alias) {
    return $LocalTxnsTable(attachedDatabase, alias);
  }
}

class LocalTxn extends DataClass implements Insertable<LocalTxn> {
  final int id;
  final DateTime date;
  final String description;
  final int amountCents;
  const LocalTxn({
    required this.id,
    required this.date,
    required this.description,
    required this.amountCents,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    map['amount_cents'] = Variable<int>(amountCents);
    return map;
  }

  LocalTxnsCompanion toCompanion(bool nullToAbsent) {
    return LocalTxnsCompanion(
      id: Value(id),
      date: Value(date),
      description: Value(description),
      amountCents: Value(amountCents),
    );
  }

  factory LocalTxn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTxn(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'amountCents': serializer.toJson<int>(amountCents),
    };
  }

  LocalTxn copyWith({
    int? id,
    DateTime? date,
    String? description,
    int? amountCents,
  }) => LocalTxn(
    id: id ?? this.id,
    date: date ?? this.date,
    description: description ?? this.description,
    amountCents: amountCents ?? this.amountCents,
  );
  LocalTxn copyWithCompanion(LocalTxnsCompanion data) {
    return LocalTxn(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTxn(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, description, amountCents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTxn &&
          other.id == this.id &&
          other.date == this.date &&
          other.description == this.description &&
          other.amountCents == this.amountCents);
}

class LocalTxnsCompanion extends UpdateCompanion<LocalTxn> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<int> amountCents;
  const LocalTxnsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.amountCents = const Value.absent(),
  });
  LocalTxnsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String description,
    required int amountCents,
  }) : date = Value(date),
       description = Value(description),
       amountCents = Value(amountCents);
  static Insertable<LocalTxn> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<int>? amountCents,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (amountCents != null) 'amount_cents': amountCents,
    });
  }

  LocalTxnsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? description,
    Value<int>? amountCents,
  }) {
    return LocalTxnsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
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
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTxnsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalTransactionsDb extends GeneratedDatabase {
  _$LocalTransactionsDb(QueryExecutor e) : super(e);
  $LocalTransactionsDbManager get managers => $LocalTransactionsDbManager(this);
  late final $BalancesTable balances = $BalancesTable(this);
  late final $LocalTxnsTable localTxns = $LocalTxnsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [balances, localTxns];
}

typedef $$BalancesTableCreateCompanionBuilder =
    BalancesCompanion Function({Value<int> id, Value<int> amountCents});
typedef $$BalancesTableUpdateCompanionBuilder =
    BalancesCompanion Function({Value<int> id, Value<int> amountCents});

class $$BalancesTableFilterComposer
    extends Composer<_$LocalTransactionsDb, $BalancesTable> {
  $$BalancesTableFilterComposer({
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

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BalancesTableOrderingComposer
    extends Composer<_$LocalTransactionsDb, $BalancesTable> {
  $$BalancesTableOrderingComposer({
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

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BalancesTableAnnotationComposer
    extends Composer<_$LocalTransactionsDb, $BalancesTable> {
  $$BalancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );
}

class $$BalancesTableTableManager
    extends
        RootTableManager<
          _$LocalTransactionsDb,
          $BalancesTable,
          Balance,
          $$BalancesTableFilterComposer,
          $$BalancesTableOrderingComposer,
          $$BalancesTableAnnotationComposer,
          $$BalancesTableCreateCompanionBuilder,
          $$BalancesTableUpdateCompanionBuilder,
          (
            Balance,
            BaseReferences<_$LocalTransactionsDb, $BalancesTable, Balance>,
          ),
          Balance,
          PrefetchHooks Function()
        > {
  $$BalancesTableTableManager(_$LocalTransactionsDb db, $BalancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BalancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BalancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BalancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
              }) => BalancesCompanion(id: id, amountCents: amountCents),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
              }) => BalancesCompanion.insert(id: id, amountCents: amountCents),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BalancesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalTransactionsDb,
      $BalancesTable,
      Balance,
      $$BalancesTableFilterComposer,
      $$BalancesTableOrderingComposer,
      $$BalancesTableAnnotationComposer,
      $$BalancesTableCreateCompanionBuilder,
      $$BalancesTableUpdateCompanionBuilder,
      (Balance, BaseReferences<_$LocalTransactionsDb, $BalancesTable, Balance>),
      Balance,
      PrefetchHooks Function()
    >;
typedef $$LocalTxnsTableCreateCompanionBuilder =
    LocalTxnsCompanion Function({
      Value<int> id,
      required DateTime date,
      required String description,
      required int amountCents,
    });
typedef $$LocalTxnsTableUpdateCompanionBuilder =
    LocalTxnsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> description,
      Value<int> amountCents,
    });

class $$LocalTxnsTableFilterComposer
    extends Composer<_$LocalTransactionsDb, $LocalTxnsTable> {
  $$LocalTxnsTableFilterComposer({
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

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalTxnsTableOrderingComposer
    extends Composer<_$LocalTransactionsDb, $LocalTxnsTable> {
  $$LocalTxnsTableOrderingComposer({
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

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalTxnsTableAnnotationComposer
    extends Composer<_$LocalTransactionsDb, $LocalTxnsTable> {
  $$LocalTxnsTableAnnotationComposer({
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

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );
}

class $$LocalTxnsTableTableManager
    extends
        RootTableManager<
          _$LocalTransactionsDb,
          $LocalTxnsTable,
          LocalTxn,
          $$LocalTxnsTableFilterComposer,
          $$LocalTxnsTableOrderingComposer,
          $$LocalTxnsTableAnnotationComposer,
          $$LocalTxnsTableCreateCompanionBuilder,
          $$LocalTxnsTableUpdateCompanionBuilder,
          (
            LocalTxn,
            BaseReferences<_$LocalTransactionsDb, $LocalTxnsTable, LocalTxn>,
          ),
          LocalTxn,
          PrefetchHooks Function()
        > {
  $$LocalTxnsTableTableManager(_$LocalTransactionsDb db, $LocalTxnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalTxnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalTxnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalTxnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
              }) => LocalTxnsCompanion(
                id: id,
                date: date,
                description: description,
                amountCents: amountCents,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String description,
                required int amountCents,
              }) => LocalTxnsCompanion.insert(
                id: id,
                date: date,
                description: description,
                amountCents: amountCents,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalTxnsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalTransactionsDb,
      $LocalTxnsTable,
      LocalTxn,
      $$LocalTxnsTableFilterComposer,
      $$LocalTxnsTableOrderingComposer,
      $$LocalTxnsTableAnnotationComposer,
      $$LocalTxnsTableCreateCompanionBuilder,
      $$LocalTxnsTableUpdateCompanionBuilder,
      (
        LocalTxn,
        BaseReferences<_$LocalTransactionsDb, $LocalTxnsTable, LocalTxn>,
      ),
      LocalTxn,
      PrefetchHooks Function()
    >;

class $LocalTransactionsDbManager {
  final _$LocalTransactionsDb _db;
  $LocalTransactionsDbManager(this._db);
  $$BalancesTableTableManager get balances =>
      $$BalancesTableTableManager(_db, _db.balances);
  $$LocalTxnsTableTableManager get localTxns =>
      $$LocalTxnsTableTableManager(_db, _db.localTxns);
}
