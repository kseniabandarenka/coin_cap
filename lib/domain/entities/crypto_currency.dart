import 'package:equatable/equatable.dart';

class CryptoCurrency extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final double priceUsd;

  const CryptoCurrency({
    required this.id,
    required this.symbol,
    required this.name,
    required this.priceUsd,
  });

  @override
  List<Object> get props => [id, symbol, name, priceUsd];

  CryptoCurrency copyWith({
    String? id,
    String? symbol,
    String? name,
    double? priceUsd,
  }) {
    return CryptoCurrency(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      priceUsd: priceUsd ?? this.priceUsd,
    );
  }
}
