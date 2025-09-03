import '../repositories/crypto_repository.dart';
import '../entities/crypto_currency.dart';

class GetCryptocurrencies {
  final CryptoRepository repository;

  GetCryptocurrencies(this.repository);

  Future<List<CryptoCurrency>> execute({int limit = 20, int offset = 0}) {
    return repository.getTopCryptocurrencies(limit: limit, offset: offset);
  }
}
