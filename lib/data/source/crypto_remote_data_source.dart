import 'package:coin_cap/data/source/api/crypto_api_service.dart';
import 'package:coin_cap/data/source/models/crypto_currency_model.dart';

abstract class CryptoRemoteDataSource {
  Future<List<CryptoCurrencyModel>> getTopCryptocurrencies({
    int limit = 15,
    int offset = 0,
  });
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final CryptoApiService apiService;

  CryptoRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<CryptoCurrencyModel>> getTopCryptocurrencies({
    int limit = 15,
    int offset = 0,
  }) async {
    try {
      final response = await apiService.getCryptocurrencies(limit, offset);
      return response.data;
    } catch (e) {
      throw Exception('Failed to load cryptocurrencies: $e');
    }
  }
}
