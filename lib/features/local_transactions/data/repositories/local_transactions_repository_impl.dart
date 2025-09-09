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
    final cents = await balanceDao.getAmountCents();
    return mapAmountCentsToEntity(cents);
  }

  @override
  Future<List<LocalTransactionsTransactionEntity>> getRecentTransactions({int limit = 5}) async {
    final rows = await transactionDao.getRecent(limit: limit);
    return rows.map(mapLocalTxnRowToEntity).toList();
  }

  @override
  Future<(LocalTransactionsBalanceEntity, LocalTransactionsTransactionEntity)> sendMoney({
    required String beneficiaryName,
    required String accountNumber,
    required int amountCents,
  }) async {
    if (amountCents <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }
    // Mask last 4 digits
    String maskAcc(String acc) {
      final raw = acc.replaceAll(' ', '');
      if (raw.length <= 4) return raw;
      return '•••• ${raw.substring(raw.length - 4)}';
    }

    return await db.transaction(() async {
      final current = await balanceDao.getAmountCents();
      if (amountCents > current) {
        throw StateError('Insufficient balance');
      }

      final newBalance = current - amountCents;
      await balanceDao.upsertAmountCents(newBalance);

      final description = 'Transfer to $beneficiaryName (${maskAcc(accountNumber)})';
      final id = await transactionDao.insertTransaction(
        date: DateTime.now(),
        description: description,
        amountCents: -amountCents, // debit
      );

      final txnRow = LocalTxn(
        id: id,
        date: DateTime.now(),
        description: description,
        amountCents: -amountCents,
      );

      return (
      LocalTransactionsBalanceEntity(newBalance),
      mapLocalTxnRowToEntity(txnRow),
      );
    });
  }
}
