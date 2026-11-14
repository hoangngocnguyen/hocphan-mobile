import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_colors.dart';
import 'package:shop_easy/features/order/widgets/order_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<_OrderTabData> _tabs = const [
    _OrderTabData(label: 'Chờ xử lý', status: 'pending'),
    _OrderTabData(label: 'Đang giao', status: 'shipping'),
    _OrderTabData(label: 'Đã giao', status: 'completed'),
  ];

  final List<Map<String, dynamic>> _orders = const [
    {
      'status': 'pending',
      'orderCode': '#DH-2026-0148',
      'productName': 'Laptop Lenovo ThinkBook 14 G6 IRL 21KG00BXVN',
      'imageUrl': 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-5.jpg?v=1730690560750',
      'deliveryMessage': 'Đang chờ xác nhận',
      'quantity': 1,
      'total': 21990000.0,
      'accentColor': Color(0xFFF59E0B),
    },
    {
      'status': 'shipping',
      'orderCode': '#DH-2026-0151',
      'productName': 'Áo khoác gió thể thao trượt nước cao cấp',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSXioZHMB2KS5qQSorYjEG6AoyXaqeaAMSHRMt4DaYtQ&s=10',
      'deliveryMessage': 'Nhân viên đang giao',
      'quantity': 2,
      'total': 640000.0,
      'accentColor': Color(0xFF2563EB),
    },
    {
      'status': 'completed',
      'orderCode': '#DH-2026-0162',
      'productName': 'Laptop Asus Vivobook 16 X1605VA-MB360W',
      'imageUrl': 'https://cdn.tgdd.vn/Products/Images/44/309375/asus-vivobook-16-x1605va-i5-mb360w-glr-14-750x500.jpg',
      'deliveryMessage': 'Đã giao thành công',
      'quantity': 1,
      'total': 18490000.0,
      'accentColor': Color(0xFF10B981),
    },
    {
      'status': 'pending',
      'orderCode': '#DH-2026-0109',
      'productName': 'Laptop Lenovo IdeaPad Slim 3 15IAH8',
      'imageUrl': 'https://cdn.tgdd.vn/Products/Images/44/313333/Slider/vi-vn-lenovo-ideapad-slim-3-15iah8-i5-83er00evn-slider-3.jpg',
      'deliveryMessage': 'Đang chuẩn bị hàng',
      'quantity': 1,
      'total': 14990000.0,
      'accentColor': Color(0xFFF59E0B),
    },
    {
      'status': 'pending',
      'orderCode': '#DH-2026-0148',
      'productName': 'Laptop Lenovo ThinkBook 14 G6 IRL 21KG00BXVN',
      'imageUrl': 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-5.jpg?v=1730690560750',
      'deliveryMessage': 'Đang chờ xác nhận',
      'quantity': 1,
      'total': 21990000.0,
      'accentColor': Color(0xFFF59E0B),
    },
    {
      'status': 'shipping',
      'orderCode': '#DH-2026-0151',
      'productName': 'Áo khoác gió thể thao trượt nước cao cấp',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSXioZHMB2KS5qQSorYjEG6AoyXaqeaAMSHRMt4DaYtQ&s=10',
      'deliveryMessage': 'Nhân viên đang giao',
      'quantity': 2,
      'total': 640000.0,
      'accentColor': Color(0xFF2563EB),
    },
    {
      'status': 'completed',
      'orderCode': '#DH-2026-0162',
      'productName': 'Laptop Asus Vivobook 16 X1605VA-MB360W',
      'imageUrl': 'https://cdn.tgdd.vn/Products/Images/44/309375/asus-vivobook-16-x1605va-i5-mb360w-glr-14-750x500.jpg',
      'deliveryMessage': 'Đã giao thành công',
      'quantity': 1,
      'total': 18490000.0,
      'accentColor': Color(0xFF10B981),
    },
    {
      'status': 'pending',
      'orderCode': '#DH-2026-0109',
      'productName': 'Laptop Lenovo IdeaPad Slim 3 15IAH8',
      'imageUrl': 'https://cdn.tgdd.vn/Products/Images/44/313333/Slider/vi-vn-lenovo-ideapad-slim-3-15iah8-i5-83er00evn-slider-3.jpg',
      'deliveryMessage': 'Đang chuẩn bị hàng',
      'quantity': 1,
      'total': 14990000.0,
      'accentColor': Color(0xFFF59E0B),
    },
    {
      'status': 'pending',
      'orderCode': '#DH-2026-0148',
      'productName': 'Laptop Lenovo ThinkBook 14 G6 IRL 21KG00BXVN',
      'imageUrl': 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-5.jpg?v=1730690560750',
      'deliveryMessage': 'Đang chờ xác nhận',
      'quantity': 1,
      'total': 21990000.0,
      'accentColor': Color(0xFFF59E0B),
    },
    {
      'status': 'shipping',
      'orderCode': '#DH-2026-0151',
      'productName': 'Áo khoác gió thể thao trượt nước cao cấp',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSXioZHMB2KS5qQSorYjEG6AoyXaqeaAMSHRMt4DaYtQ&s=10',
      'deliveryMessage': 'Nhân viên đang giao',
      'quantity': 2,
      'total': 640000.0,
      'accentColor': Color(0xFF2563EB),
    },
    {
      'status': 'completed',
      'orderCode': '#DH-2026-0162',
      'productName': 'Laptop Asus Vivobook 16 X1605VA-MB360W',
      'imageUrl': 'https://cdn.tgdd.vn/Products/Images/44/309375/asus-vivobook-16-x1605va-i5-mb360w-glr-14-750x500.jpg',
      'deliveryMessage': 'Đã giao thành công',
      'quantity': 1,
      'total': 18490000.0,
      'accentColor': Color(0xFF10B981),
    },
    {
      'status': 'pending',
      'orderCode': '#DH-2026-0109',
      'productName': 'Laptop Lenovo IdeaPad Slim 3 15IAH8',
      'imageUrl': 'https://cdn.tgdd.vn/Products/Images/44/313333/Slider/vi-vn-lenovo-ideapad-slim-3-15iah8-i5-83er00evn-slider-3.jpg',
      'deliveryMessage': 'Đang chuẩn bị hàng',
      'quantity': 1,
      'total': 14990000.0,
      'accentColor': Color(0xFFF59E0B),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _ordersByStatus(String status) {
    return _orders.where((order) => order['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Đơn hàng của tôi',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          // 1. Thanh Status Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue, // Màu chữ của tab đang chọn
              unselectedLabelColor: Colors.grey, // Màu chữ của tab chưa chọn
              indicatorColor: Colors.blue, // Màu của gạch chân xanh
              indicatorWeight: 3.0, // Độ dày của gạch chân
              indicatorSize:
                  TabBarIndicatorSize.tab, // Độ rộng gạch chân theo tab
              tabs: _tabs.map((tab) => Tab(text: tab.label)).toList(),
            ),
          ),

          // 2. Danh sách Order kết hợp AutomaticKeepAliveClientMixin qua _OrderTabPage
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((tab) {
                final items = _ordersByStatus(tab.status);
                
                return _OrderTabPage(items: items, tabLabel: tab.label);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget con giúp giữ nguyên vị trí cuộn cho từng tab
class _OrderTabPage extends StatefulWidget {
  final List items;
  final String tabLabel;

  const _OrderTabPage({required this.items, required this.tabLabel});

  @override
  State<_OrderTabPage> createState() => _OrderTabPageState();
}

class _OrderTabPageState extends State<_OrderTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Giữ trạng thái, không bị reset vị trí cuộn khi đổi tab

  @override
  Widget build(BuildContext context) {
    super.build(context); // Bắt buộc gọi super.build(context)

    if (widget.items.isEmpty) {
      return _EmptyOrderState(tabLabel: widget.tabLabel);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: widget.items
          .map(
            (order) => OrderCard(
              orderCode: order['orderCode'],
              productName: order['productName'],
              imageUrl: order['imageUrl'],
              status: widget.tabLabel,
              deliveryMessage: order['deliveryMessage'],
              quantity: order['quantity'],
              total: order['total'],
              accentColor: order['accentColor'],
            ),
          )
          .toList(),
    );
  }
}

class _EmptyOrderState extends StatelessWidget {
  final String tabLabel;

  const _EmptyOrderState({required this.tabLabel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.inbox_outlined,
                size: 62,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Chưa có đơn hàng',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bạn chưa có đơn hàng nào ở tab "$tabLabel".',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderTabData {
  final String label;
  final String status;

  const _OrderTabData({required this.label, required this.status});
}
