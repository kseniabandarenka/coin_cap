import 'package:coin_cap/data/gateways/crypto_gateway.dart';
import 'package:coin_cap/data/source/api/crypto_api_service.dart';
import 'package:coin_cap/data/source/crypto_remote_data_source.dart';
import 'package:coin_cap/domain/usecases/get_cryptocurrencies.dart';
import 'package:coin_cap/presentation/pages/crypto_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://rest.coincap.io/v3/',
        headers: {
          "Authorization":
              "Bearer 0ff41f3dee26a4dedbecba44e49fc424ea6bbed98b91c6bb285be5e9e3a13b41",
        },
      ),
    );

    final CryptoApiService apiService = CryptoApiService(dio);
    final CryptoRemoteDataSource remoteDataSource = CryptoRemoteDataSourceImpl(
      apiService: apiService,
    );
    final CryptoGateway gateway = CryptoGateway(
      remoteDataSource: remoteDataSource,
    );
    final GetCryptocurrencies getCryptocurrencies = GetCryptocurrencies(
      gateway,
    );

    return RepositoryProvider.value(
      value: getCryptocurrencies,
      child: MaterialApp(
        title: 'Crypto App',
        theme: ThemeData(useMaterial3: true),
        home: const CryptoListPage(),
      ),
    );
  }
}
