enum PriceCurrency { usd, vnd }

class AppFormatters {
  static PriceCurrency activeCurrency = PriceCurrency.usd;

  /// Hàm dùng chung cho toàn bộ UI (Card, Detail, Cart...)
  static String formatPrice(num? price, {PriceCurrency? currency}) {
    final target = currency ?? activeCurrency;
    switch (target) {
      case PriceCurrency.usd:
        return formatUsd(price);
      case PriceCurrency.vnd:
        return formatCurrency(price);
    }
  }

  /// Định dạng giá tiền VNĐ (ví dụ: 12900000 -> 12.900.000 ₫)
  static String formatCurrency(num? price) {
    if (price == null) return '0 ₫';
    final formatted = price
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return '$formatted ₫';
  }

  /// Định dạng giá tiền USD (ví dụ: 9.99 -> $9.99)
  static String formatUsd(num? price, {int decimals = 2}) {
    if (price == null) return '\$0.00';

    final parts = price.toStringAsFixed(decimals).split('.');
    final formattedInt = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    if (decimals == 0 || parts.length == 1) {
      return '\$$formattedInt';
    }
    return '\$$formattedInt.${parts[1]}';
  }
}