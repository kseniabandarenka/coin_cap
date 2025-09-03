import 'package:coin_cap/data/source/models/crypto_currency_model.dart';
import '../../domain/entities/crypto_currency.dart';

class CryptoMapper {
  static CryptoCurrency toEntity(CryptoCurrencyModel model) {
    return CryptoCurrency(
      id: model.id,
      symbol: model.symbol,
      name: model.name,
      priceUsd: double.tryParse(model.priceUsd) ?? 0.0,
    );
  }

  static List<CryptoCurrency> toEntityList(List<CryptoCurrencyModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }
}
