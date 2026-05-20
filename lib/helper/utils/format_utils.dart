import 'package:intl/intl.dart';

class FormatUtils {
  /// Indian currency format (₹ 1,00,000)
  static String formatCurrency(num? amount) {
    if (amount == null) return "₹ 0";

    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹ ',
      decimalDigits: 0,
    );

    return formatter.format(amount);
  }

  /// Number only (1,00,000)
  static String formatNumber(num? amount) {
    if (amount == null) return "0";

    final formatter = NumberFormat('#,##,##0', 'en_IN');
    return formatter.format(amount);
  }
}