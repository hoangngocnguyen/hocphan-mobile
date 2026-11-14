import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_colors.dart';
import 'package:shop_easy/core/utils/formatters.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  static const List<_MetricData> _metrics = [
    _MetricData(
      label: 'Đơn hàng',
      value: '2,146',
      change: '+9.4%',
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF59E0B),
    ),
    _MetricData(
      label: 'Doanh thu',
      value: '₫248M',
      change: '+11.8%',
      icon: Icons.attach_money_rounded,
      accent: Color(0xFF10B981),
    ),
    _MetricData(
      label: 'Khách hàng',
      value: '12.4K',
      change: '+18.2%',
      icon: Icons.people_alt_rounded,
      accent: Color(0xFF2563EB),
    ),
    _MetricData(
      label: 'Sản phẩm',
      value: '89.7K',
      change: '+24.1%',
      icon: Icons.inventory_2_rounded,
      accent: Color(0xFFEC4899),
    ),
  ];

  static const List _recentOrders = [
    {
      'status': 'pending',
      'orderCode': '#DH-2026-0148',
      'productName': 'Laptop Lenovo ThinkBook 14 G6 IRL 21KG00BXVN',
      'imageUrl':
          'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-5.jpg?v=1730690560750',
      'deliveryMessage': 'Đang chờ xác nhận',
      'quantity': 1,
      'total': 21990000.0,
      'accentColor': Color(0xFFF59E0B),
    },
    {
      'status': 'shipping',
      'orderCode': '#DH-2026-0151',
      'productName': 'Áo khoác gió thể thao trượt nước cao cấp',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSXioZHMB2KS5qQSorYjEG6AoyXaqeaAMSHRMt4DaYtQ&s=10',
      'deliveryMessage': 'Nhân viên đang giao',
      'quantity': 2,
      'total': 640000.0,
      'accentColor': Color(0xFF2563EB),
    },
    {
      'status': 'completed',
      'orderCode': '#DH-2026-0162',
      'productName': 'Laptop Asus Vivobook 16 X1605VA-MB360W',
      'imageUrl':
          'https://cdn.tgdd.vn/Products/Images/44/309375/asus-vivobook-16-x1605va-i5-mb360w-glr-14-750x500.jpg',
      'deliveryMessage': 'Đã giao thành công',
      'quantity': 1,
      'total': 18490000.0,
      'accentColor': Color(0xFF10B981),
    },
    {
      'status': 'pending',
      'orderCode': '#DH-2026-0109',
      'productName': 'Laptop Lenovo IdeaPad Slim 3 15IAH8',
      'imageUrl':
          'https://cdn.tgdd.vn/Products/Images/44/313333/Slider/vi-vn-lenovo-ideapad-slim-3-15iah8-i5-83er00evn-slider-3.jpg',
      'deliveryMessage': 'Đang chuẩn bị hàng',
      'quantity': 1,
      'total': 14990000.0,
      'accentColor': Color(0xFFF59E0B),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= 720 ? 4 : 2;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: const Text(
          'Tổng quan',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 1. Lưới 4 ô số liệu (2 cột trên mobile, 4 cột khi màn hình rộng >= 720dp)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth = constraints.maxWidth;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      shrinkWrap: true,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: cardWidth >= 700 ? 1.4 : 1.1,
                      children: _metrics.map((metric) {
                        return _MetricCard(metric: metric);
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
            
            // 2. Khu vực Đơn hàng gần đây (tiêu đề + nút "Xem tất cả" căn phải + danh sách đơn hàng)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFE6EDF5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Đơn hàng gần đây',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Xem tất cả'),
                            ),
                          ],
                        ),
                      ),
                      ..._recentOrders.map((order) {
                        final status = order['status'] as String;
                        final statusColor = switch (status) {
                          'pending' => const Color(0xFFF59E0B),
                          'shipping' => const Color(0xFF2563EB),
                          'completed' => const Color(0xFF10B981),
                          _ => AppColors.primary,
                        };
                        final statusText = switch (status) {
                          'pending' => 'Chờ xử lý',
                          'shipping' => 'Đang giao',
                          'completed' => 'Đã giao',
                          _ => 'Khác',
                        };
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE8EEF5)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  order['imageUrl'] as String,
                                  width: 68,
                                  height: 68,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 68,
                                    height: 68,
                                    color: AppColors.primaryLight,
                                    child: const Icon(
                                      Icons.image_not_supported_rounded,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order['orderCode'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      order['productName'] as String,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withValues(
                                                alpha: 0.12),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            statusText,
                                            style: TextStyle(
                                              color: statusColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${order['quantity']} sản phẩm',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    AppFormatters.formatCurrency((order['total'] as num)),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    order['deliveryMessage'] as String,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: statusColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricData {
  final String label;
  final String value;
  final String change;
  final IconData icon;
  final Color accent;

  const _MetricData({
    required this.label,
    required this.value,
    required this.change,
    required this.icon,
    required this.accent,
  });
}

class _MetricCard extends StatelessWidget {
  final _MetricData metric;

  const _MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4EAF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: metric.accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(metric.icon, color: metric.accent, size: 22),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F9EF),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  metric.change,
                  style: const TextStyle(
                    color: Color(0xFF16A34A),
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            metric.value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            metric.label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}