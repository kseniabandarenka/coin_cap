import 'package:json_annotation/json_annotation.dart';
import 'crypto_currency_model.dart';

part 'crypto_currency_response.g.dart';

@JsonSerializable()
class CryptoCurrencyResponse {
  final List<CryptoCurrencyModel> data;
  final int timestamp;

  CryptoCurrencyResponse({required this.data, required this.timestamp});

  factory CryptoCurrencyResponse.fromJson(Map<String, dynamic> json) =>
      _$CryptoCurrencyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCurrencyResponseToJson(this);
}
