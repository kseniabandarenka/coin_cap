import 'package:coin_cap/domain/usecases/get_cryptocurrencies.dart';
import 'package:coin_cap/presentation/pages/bloc/crypto_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/crypto_list_item.dart';

const _mediumPadding = 24.0;

class CryptoListPage extends StatelessWidget {
  const CryptoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CryptoListBloc(
          getCryptocurrencies: context.read<GetCryptocurrencies>(),
        )..add(CryptoListFetchInitial()),
        child: const _CryptoListView(),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _CryptoListView extends StatefulWidget {
  const _CryptoListView();

  @override
  State<_CryptoListView> createState() => _CryptoListViewState();
}

class _CryptoListViewState extends State<_CryptoListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<CryptoListBloc>().add(CryptoListFetchMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoListBloc, CryptoListState>(
      builder: (context, state) {
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, CryptoListState state) {
    if (state is CryptoListInitial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CryptoListLoading && state.cryptocurrencies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CryptoListFailure) {
      return _buildError(context, state.error);
    } else {
      return _buildList(context, state);
    }
  }

  Widget _buildList(BuildContext context, CryptoListState state) {
    final cryptocurrencies = state.cryptocurrencies;
    final isLoadingMore = state is CryptoListSuccess && state.isLoadingMore;
    final hasReachedMax = state is CryptoListSuccess && state.hasReachedMax;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CryptoListBloc>().add(CryptoListFetchInitial());
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            cryptocurrencies.length +
            (isLoadingMore ? 1 : 0) +
            (hasReachedMax ? 0 : 0),
        itemBuilder: (context, index) {
          if (index >= cryptocurrencies.length) {
            if (isLoadingMore) {
              return Padding(
                padding: const EdgeInsets.all(_mediumPadding),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (!hasReachedMax && index == cryptocurrencies.length) {
              return const SizedBox.shrink();
            }
          }

          final crypto = cryptocurrencies[index];
          return CryptoListItem(crypto: crypto, index: index);
        },
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error loading data',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: _mediumPadding),
          ElevatedButton(
            onPressed: () {
              context.read<CryptoListBloc>().add(CryptoListFetchInitial());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: _mediumPadding,
                vertical: _mediumPadding,
              ),
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
