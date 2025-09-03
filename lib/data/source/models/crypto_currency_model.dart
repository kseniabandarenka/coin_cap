import 'package:json_annotation/json_annotation.dart';

part 'crypto_currency_model.g.dart';

@JsonSerializable()
class CryptoCurrencyModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'symbol')
  final String symbol;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'priceUsd')
  final String priceUsd;

  const CryptoCurrencyModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.priceUsd,
  });

  factory CryptoCurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoCurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCurrencyModelToJson(this);
}
