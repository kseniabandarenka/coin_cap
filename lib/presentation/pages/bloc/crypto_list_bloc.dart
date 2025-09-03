import 'package:coin_cap/domain/entities/crypto_currency.dart';
import 'package:coin_cap/domain/usecases/get_cryptocurrencies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "crypto_list_event.dart";
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  final GetCryptocurrencies getCryptocurrencies;
  static const int _pageSize = 15;

  CryptoListBloc({required this.getCryptocurrencies})
    : super(const CryptoListInitial()) {
    on<CryptoListFetchInitial>(_onFetchInitial);
    on<CryptoListFetchMore>(_onFetchMore);
  }

  Future<void> _onFetchInitial(
    CryptoListFetchInitial event,
    Emitter<CryptoListState> emit,
  ) async {
    try {
      emit(const CryptoListLoading());

      final cryptocurrencies = await getCryptocurrencies.execute(
        limit: _pageSize,
        offset: 0,
      );

      emit(
        CryptoListSuccess(
          cryptocurrencies: cryptocurrencies,
          currentOffset: _pageSize,
          hasReachedMax: cryptocurrencies.length < _pageSize,
        ),
      );
    } catch (error) {
      emit(CryptoListFailure(error.toString()));
    }
  }

  Future<void> _onFetchMore(
    CryptoListFetchMore event,
    Emitter<CryptoListState> emit,
  ) async {
    final currentState = state;

    if (currentState is CryptoListSuccess &&
        !currentState.hasReachedMax &&
        !currentState.isLoadingMore) {
      try {
        emit(currentState.copyWith(isLoadingMore: true));

        final newCryptocurrencies = await getCryptocurrencies.execute(
          limit: _pageSize,
          offset: currentState.currentOffset,
        );

        if (newCryptocurrencies.isEmpty) {
          emit(
            currentState.copyWith(hasReachedMax: true, isLoadingMore: false),
          );
        } else {
          final allCryptocurrencies = [
            ...currentState.cryptocurrencies,
            ...newCryptocurrencies,
          ];

          emit(
            CryptoListSuccess(
              cryptocurrencies: allCryptocurrencies,
              currentOffset:
                  currentState.currentOffset + newCryptocurrencies.length,
              hasReachedMax: newCryptocurrencies.length < _pageSize,
              isLoadingMore: false,
            ),
          );
        }
      } catch (error) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }
}
