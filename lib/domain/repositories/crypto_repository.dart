import '../entities/crypto_currency.dart';

abstract class CryptoRepository {
  Future<List<CryptoCurrency>> getTopCryptocurrencies({
    int limit = 20,
    int offset = 0,
  });

  Future<CryptoCurrency> getCryptoDetail(String id);
}
