import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crypto_currency.dart';
import '../utils/color_generator.dart';

const _leadingSize = 56.0;
const _leadingBorderRadius = 16.0;
const _verticalPadding = 14.0;
const _horizontalPadding = 20.0;
const _horizontalTitleGap = 16.0;

const _textStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 17,
  letterSpacing: 0.41,
  height: 0.24,
);

class CryptoListItem extends StatelessWidget {
  final CryptoCurrency crypto;
  final int index;

  const CryptoListItem({super.key, required this.crypto, required this.index});

  String _formatCurrency(double value) {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(value);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = ColorGenerator.generateColorFromSeed(index);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: _verticalPadding),
      child: ListTile(
        horizontalTitleGap: _horizontalTitleGap,
        contentPadding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        leading: Container(
          width: _leadingSize,
          height: _leadingSize,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(_leadingBorderRadius),
          ),
        ),
        title: Text(crypto.symbol.toUpperCase(), style: _textStyle),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [Text(_formatCurrency(crypto.priceUsd), style: _textStyle)],
        ),
      ),
    );
  }
}
