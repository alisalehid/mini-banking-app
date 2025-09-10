import '../../domain/entities/local_transactions_balance_entity.dart';
import '../../domain/entities/local_transactions_transaction_entity.dart';
import '../../domain/repositories/local_transactions_repository.dart';
import '../../infrastructure/db/local_transactions_db.dart';
import '../../infrastructure/db/daos/balance_dao.dart';
import '../../infrastructure/db/daos/transaction_dao.dart';
import '../mappers/balance_mapper.dart';
import '../mappers/transaction_mapper.dart';

class LocalTransactionsRepositoryImpl implements LocalTransactionsRepository {
  final LocalTransactionsDb db;
  final BalanceDao balanceDao;
  final TransactionDao transactionDao;

  LocalTransactionsRepositoryImpl({
    required this.db,
    required this.balanceDao,
    required this.transactionDao,
  });

  @override
  Future<LocalTransactionsBalanceEntity> getBalance() async {
    final cents = await balanceDao.getAmount();
    return mapAmountCentsToEntity(cents.toString());
  }

  @override
  Future<List<LocalTransactionsTransactionEntity>> getRecentTransactions({int limit = 5}) async {
    final rows = await transactionDao.getRecent(limit: limit);
    return rows.map(mapLocalTxnRowToEntity).toList();
  }

  @override
  Future<(LocalTransactionsBalanceEntity, LocalTransactionsTransactionEntity)> sendMoney({
    required String beneficiaryName,
    required String amount,
    required String status ,
    required String account ,
  }) async {
    if (parseNumber(amount) <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }
    // Mask last 4 digits
    String maskAcc(String acc) {
      final raw = acc.replaceAll(' ', '');
      if (raw.length <= 4) return raw;
      return '•••• ${raw.substring(raw.length - 4)}';
    }

    return await db.transaction(() async {
      final current = await balanceDao.getAmount();
      final amountNum = parseNumber(amount);
      if (amountNum > current) {
        throw StateError('Insufficient balance');
      }

      final newBalance = current - amountNum;
      await balanceDao.upsertAmount(parseNumber(newBalance.toString()));

      final description = 'Transfer to $beneficiaryName (${maskAcc(account)})';
      final amountInt = amountNum.toInt();

      final id = await transactionDao.insertTransaction(
        date: DateTime.now(),
        description: description,
        amount: -amountInt,
        status : status ,
        account: account
      );

      final txnRow = LocalTxn(
        id: id,
        date: DateTime.now(),
        description: description,
        amount: -amountInt,
        status: status ,
        account: account
      );

      return (
      LocalTransactionsBalanceEntity(newBalance.toString()),
      mapLocalTxnRowToEntity(txnRow),
      );
    });
  }

  dynamic parseNumber(String value) {
    double parsed = double.parse(value);
    // If it has no decimal part, return int
    if (parsed % 1 == 0) {
      return parsed.toInt();
    } else {
      return parsed;
    }
  }
}
