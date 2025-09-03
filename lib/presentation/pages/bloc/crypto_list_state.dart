part of 'crypto_list_bloc.dart';

@immutable
sealed class CryptoListState extends Equatable {
  final List<CryptoCurrency> cryptocurrencies;
  final int currentOffset;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const CryptoListState({
    this.cryptocurrencies = const [],
    this.currentOffset = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props => [
    cryptocurrencies,
    currentOffset,
    hasReachedMax,
    isLoadingMore,
  ];
}

class CryptoListInitial extends CryptoListState {
  const CryptoListInitial();
}

class CryptoListLoading extends CryptoListState {
  const CryptoListLoading({
    super.cryptocurrencies,
    super.currentOffset,
    super.hasReachedMax,
    super.isLoadingMore = false,
  });
}

class CryptoListSuccess extends CryptoListState {
  const CryptoListSuccess({
    required super.cryptocurrencies,
    required super.currentOffset,
    required super.hasReachedMax,
    super.isLoadingMore = false,
  });

  CryptoListSuccess copyWith({
    List<CryptoCurrency>? cryptocurrencies,
    int? currentOffset,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return CryptoListSuccess(
      cryptocurrencies: cryptocurrencies ?? this.cryptocurrencies,
      currentOffset: currentOffset ?? this.currentOffset,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class CryptoListFailure extends CryptoListState {
  final String error;

  const CryptoListFailure(this.error);

  @override
  List<Object> get props => [error, ...super.props];
}
