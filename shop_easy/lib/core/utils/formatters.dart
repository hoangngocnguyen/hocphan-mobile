class AppFormatters {
  /// Định dạng giá tiền VNĐ (ví dụ: 12900000 -> 12.900.000 ₫)
  static String formatCurrency(num? price) {
    if (price == null) return '0 ₫';
    return '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} ₫';
  }
}
