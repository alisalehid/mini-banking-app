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
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, amount];
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
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
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
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
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
  final int amount;
  const Balance({required this.id, required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  BalancesCompanion toCompanion(bool nullToAbsent) {
    return BalancesCompanion(id: Value(id), amount: Value(amount));
  }

  factory Balance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Balance(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
    };
  }

  Balance copyWith({int? id, int? amount}) =>
      Balance(id: id ?? this.id, amount: amount ?? this.amount);
  Balance copyWithCompanion(BalancesCompanion data) {
    return Balance(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Balance(')
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
      (other is Balance && other.id == this.id && other.amount == this.amount);
}

class BalancesCompanion extends UpdateCompanion<Balance> {
  final Value<int> id;
  final Value<int> amount;
  const BalancesCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
  });
  BalancesCompanion.insert({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
  });
  static Insertable<Balance> custom({
    Expression<int>? id,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
    });
  }

  BalancesCompanion copyWith({Value<int>? id, Value<int>? amount}) {
    return BalancesCompanion(id: id ?? this.id, amount: amount ?? this.amount);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalancesCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount')
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
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountMeta = const VerificationMeta(
    'account',
  );
  @override
  late final GeneratedColumn<String> account = GeneratedColumn<String>(
    'account',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    description,
    amount,
    status,
    account,
  ];
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
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('account')) {
      context.handle(
        _accountMeta,
        account.isAcceptableOrUnknown(data['account']!, _accountMeta),
      );
    } else if (isInserting) {
      context.missing(_accountMeta);
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
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      account: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account'],
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
  final int amount;
  final String status;
  final String account;
  const LocalTxn({
    required this.id,
    required this.date,
    required this.description,
    required this.amount,
    required this.status,
    required this.account,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    map['amount'] = Variable<int>(amount);
    map['status'] = Variable<String>(status);
    map['account'] = Variable<String>(account);
    return map;
  }

  LocalTxnsCompanion toCompanion(bool nullToAbsent) {
    return LocalTxnsCompanion(
      id: Value(id),
      date: Value(date),
      description: Value(description),
      amount: Value(amount),
      status: Value(status),
      account: Value(account),
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
      amount: serializer.fromJson<int>(json['amount']),
      status: serializer.fromJson<String>(json['status']),
      account: serializer.fromJson<String>(json['account']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<int>(amount),
      'status': serializer.toJson<String>(status),
      'account': serializer.toJson<String>(account),
    };
  }

  LocalTxn copyWith({
    int? id,
    DateTime? date,
    String? description,
    int? amount,
    String? status,
    String? account,
  }) => LocalTxn(
    id: id ?? this.id,
    date: date ?? this.date,
    description: description ?? this.description,
    amount: amount ?? this.amount,
    status: status ?? this.status,
    account: account ?? this.account,
  );
  LocalTxn copyWithCompanion(LocalTxnsCompanion data) {
    return LocalTxn(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      status: data.status.present ? data.status.value : this.status,
      account: data.account.present ? data.account.value : this.account,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTxn(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('account: $account')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, description, amount, status, account);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTxn &&
          other.id == this.id &&
          other.date == this.date &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.status == this.status &&
          other.account == this.account);
}

class LocalTxnsCompanion extends UpdateCompanion<LocalTxn> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<int> amount;
  final Value<String> status;
  final Value<String> account;
  const LocalTxnsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.status = const Value.absent(),
    this.account = const Value.absent(),
  });
  LocalTxnsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String description,
    required int amount,
    required String status,
    required String account,
  }) : date = Value(date),
       description = Value(description),
       amount = Value(amount),
       status = Value(status),
       account = Value(account);
  static Insertable<LocalTxn> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<int>? amount,
    Expression<String>? status,
    Expression<String>? account,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (status != null) 'status': status,
      if (account != null) 'account': account,
    });
  }

  LocalTxnsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? description,
    Value<int>? amount,
    Value<String>? status,
    Value<String>? account,
  }) {
    return LocalTxnsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      account: account ?? this.account,
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
      map['amount'] = Variable<int>(amount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (account.present) {
      map['account'] = Variable<String>(account.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTxnsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('account: $account')
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
    BalancesCompanion Function({Value<int> id, Value<int> amount});
typedef $$BalancesTableUpdateCompanionBuilder =
    BalancesCompanion Function({Value<int> id, Value<int> amount});

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

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
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

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
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

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
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
                Value<int> amount = const Value.absent(),
              }) => BalancesCompanion(id: id, amount: amount),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> amount = const Value.absent(),
              }) => BalancesCompanion.insert(id: id, amount: amount),
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
      required int amount,
      required String status,
      required String account,
    });
typedef $$LocalTxnsTableUpdateCompanionBuilder =
    LocalTxnsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> description,
      Value<int> amount,
      Value<String> status,
      Value<String> account,
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

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get account => $composableBuilder(
    column: $table.account,
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

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get account => $composableBuilder(
    column: $table.account,
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

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get account =>
      $composableBuilder(column: $table.account, builder: (column) => column);
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
                Value<int> amount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> account = const Value.absent(),
              }) => LocalTxnsCompanion(
                id: id,
                date: date,
                description: description,
                amount: amount,
                status: status,
                account: account,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String description,
                required int amount,
                required String status,
                required String account,
              }) => LocalTxnsCompanion.insert(
                id: id,
                date: date,
                description: description,
                amount: amount,
                status: status,
                account: account,
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
