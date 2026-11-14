import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_colors.dart';
import 'package:shop_easy/core/utils/formatters.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const int _freeShippingThreshold = 500000;
  final List<Map<String, dynamic>> _items = [
    {
      'name': 'Giày Sneaker Thể Thao cao cấp',
      'price': 8900000,
      'qty': 1,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXkTNL_4eIZHiaUfHc-lMzYQ42Ess6OihOJFYvVQai8Q&s=10',
    },
    {
      'name': 'Giày Sneaker Thể Thao',
      'price': 450000,
      'qty': 2,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXkTNL_4eIZHiaUfHc-lMzYQ42Ess6OihOJFYvVQai8Q&s=10',
    },
  ];

  int get _subtotal => _items.fold<int>(
        0,
        (sum, item) => sum + (item['price'] as int) * (item['qty'] as int),
      );

  int get _shipping => _items.isEmpty || _subtotal >= _freeShippingThreshold ? 0 : 30000;

  void _changeQuantity(int index, int change) {
    setState(() {
      final next = (_items[index]['qty'] as int) + change;
      if (next <= 0) {
        final removed = _items.removeAt(index);
        _showUndo(removed, index);
      } else {
        _items[index]['qty'] = next;
      }
    });
  }

  void _removeItem(int index) {
    final removed = _items.removeAt(index);
    setState(() {});
    _showUndo(removed, index);
  }

  void _showUndo(Map<String, dynamic> item, int index) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Đã xóa ${item['name']} khỏi giỏ hàng'),
          action: SnackBarAction(
            label: 'Hoàn tác',
            onPressed: () => setState(() => _items.insert(index.clamp(0, _items.length) as int, item)),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Giỏ hàng', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: false,
      ),
      body: _items.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text('Sản phẩm của bạn', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                          ),
                          Text('${_items.length} sản phẩm', style: const TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ...List.generate(_items.length, (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildItemCard(index),
                          )),
                      _buildShippingHint(),
                    ],
                  ),
                ),
                _buildSummary(),
              ],
            ),
    );
  }

  Widget _buildItemCard(int index) {
    final item = _items[index];
    return Dismissible(
      key: ValueKey('${item['name']}-${item['price']}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _removeItem(index),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(18)),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.divider),
          boxShadow: const [BoxShadow(color: Color(0x080F172A), blurRadius: 12, offset: Offset(0, 4))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: SizedBox(
                width: 84,
                height: 84,
                child: Image.network(
                  item['imageUrl'] as String,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : const ColoredBox(color: AppColors.surfaceAlt, child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)))),
                  errorBuilder: (context, error, stackTrace) => const ColoredBox(
                    color: AppColors.surfaceAlt,
                    child: Center(child: Icon(Icons.image_not_supported_outlined, color: AppColors.muted, size: 30)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item['name'] as String, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 6),
                  Text(AppFormatters.formatCurrency(item['price'] as int), style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _quantityButton(Icons.remove, () => _changeQuantity(index, -1)),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 13), child: Text('${item['qty']}', style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
                      _quantityButton(Icons.add, () => _changeQuantity(index, 1)),
                      const Spacer(),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Xóa sản phẩm',
                        onPressed: () => _removeItem(index),
                        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) => SizedBox(
        width: 30,
        height: 30,
        child: IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: onPressed,
          icon: Icon(icon, size: 17),
          style: IconButton.styleFrom(backgroundColor: AppColors.surfaceAlt, foregroundColor: AppColors.textPrimary),
        ),
      );

  Widget _buildShippingHint() {
    final remaining = (_freeShippingThreshold - _subtotal).clamp(0, _freeShippingThreshold);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.successSoft, borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.local_shipping_outlined, color: AppColors.success, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              remaining == 0 ? 'Bạn được miễn phí vận chuyển!' : 'Mua thêm ${AppFormatters.formatCurrency(remaining)} để được miễn phí vận chuyển.',
              style: const TextStyle(color: AppColors.textPrimary, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.divider)),
          boxShadow: [BoxShadow(color: Color(0x0A0F172A), blurRadius: 14, offset: Offset(0, -4))],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _summaryRow('Tạm tính', AppFormatters.formatCurrency(_subtotal)),
              const SizedBox(height: 8),
              _summaryRow('Phí vận chuyển', _shipping == 0 ? 'Miễn phí' : AppFormatters.formatCurrency(_shipping)),
              const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
              _summaryRow('Tổng cộng', AppFormatters.formatCurrency(_subtotal + _shipping), prominent: true),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lock_outline_rounded, size: 18),
                  label: const Text('Thanh toán', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _summaryRow(String label, String value, {bool prominent = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: prominent ? 18 : 14, fontWeight: prominent ? FontWeight.w700 : FontWeight.w400, color: prominent ? AppColors.textPrimary : AppColors.textSecondary)),
          Text(value, style: TextStyle(fontSize: prominent ? 19 : 14, fontWeight: FontWeight.w700, color: prominent ? AppColors.primary : AppColors.textPrimary)),
        ],
      );

  Widget _buildEmptyCart() => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 104, height: 104, decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: const Icon(Icons.shopping_bag_outlined, size: 48, color: AppColors.primary)),
              const SizedBox(height: 22),
              const Text('Giỏ hàng đang trống', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              const Text('Hãy khám phá và chọn những sản phẩm bạn yêu thích nhé.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, height: 1.5)),
              const SizedBox(height: 22),
              FilledButton(onPressed: () => Navigator.maybePop(context), child: const Text('Tiếp tục mua sắm')),
            ],
          ),
        ),
      );
}
