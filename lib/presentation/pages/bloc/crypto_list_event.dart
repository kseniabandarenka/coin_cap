part of 'crypto_list_bloc.dart';

@immutable
abstract class CryptoListEvent extends Equatable {
  const CryptoListEvent();

  @override
  List<Object> get props => [];
}

class CryptoListFetchInitial extends CryptoListEvent {}

class CryptoListFetchMore extends CryptoListEvent {}
