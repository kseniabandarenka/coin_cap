import 'package:coin_cap/data/source/crypto_remote_data_source.dart';
import '../mapper/crypto_mapper.dart';
import '../../domain/entities/crypto_currency.dart';
import '../../domain/repositories/crypto_repository.dart';

class CryptoGateway implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;

  CryptoGateway({required this.remoteDataSource});

  @override
  Future<List<CryptoCurrency>> getTopCryptocurrencies({
    int limit = 15,
    int offset = 0,
  }) async {
    final models = await remoteDataSource.getTopCryptocurrencies(
      limit: limit,
      offset: offset,
    );
    return CryptoMapper.toEntityList(models);
  }

  @override
  Future<CryptoCurrency> getCryptoDetail(String id) {
    throw UnimplementedError('getCryptoDetail not implemented yet');
  }
}
