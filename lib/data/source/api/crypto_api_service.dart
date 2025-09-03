import 'package:coin_cap/data/source/models/crypto_currency_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'crypto_api_service.g.dart';

@RestApi()
abstract class CryptoApiService {
  factory CryptoApiService(Dio dio, {String baseUrl}) = _CryptoApiService;

  @GET('assets')
  Future<CryptoCurrencyResponse> getCryptocurrencies(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );
}
