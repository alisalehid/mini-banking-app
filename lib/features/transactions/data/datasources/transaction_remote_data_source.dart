import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/transaction_model.dart';

part 'transaction_remote_data_source.g.dart';

@RestApi(baseUrl: "https://68bf7d499c70953d96efaa49.mockapi.io/api/v1/")
abstract class TransactionRemoteDataSource {
  factory TransactionRemoteDataSource(Dio dio, {String baseUrl}) = _TransactionRemoteDataSource;

  @GET("/transactions")
  Future<List<TransactionModel>> getTransactions(
      @Query("page") int page,
      @Query("limit") int limit,
      );
}
