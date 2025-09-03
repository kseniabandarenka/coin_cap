import 'package:equatable/equatable.dart';
import 'crypto_currency.dart';

class PaginationState extends Equatable {
  final List<CryptoCurrency> items;
  final int currentOffset;
  final bool hasReachedMax;
  final bool isLoading;

  const PaginationState({
    this.items = const [],
    this.currentOffset = 0,
    this.hasReachedMax = false,
    this.isLoading = false,
  });

  PaginationState copyWith({
    List<CryptoCurrency>? items,
    int? currentOffset,
    bool? hasReachedMax,
    bool? isLoading,
  }) {
    return PaginationState(
      items: items ?? this.items,
      currentOffset: currentOffset ?? this.currentOffset,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [items, currentOffset, hasReachedMax, isLoading];
}
