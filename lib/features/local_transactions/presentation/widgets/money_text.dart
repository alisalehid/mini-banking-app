import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MoneyText extends StatelessWidget {
  final int cents;
  final TextStyle? style;
  final String locale;
  final String symbol;

  const MoneyText({
    super.key,
    required this.cents,
    this.style,
    this.locale = 'en_US',
    this.symbol = r'$',
  });

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat.currency(locale: locale, symbol: symbol, decimalDigits: 2);
    return Text(format.format(cents / 100.0), style: style);
  }
}
