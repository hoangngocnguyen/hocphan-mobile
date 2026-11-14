import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Dữ liệu thông báo quản lý trong State để có thể cập nhật trạng thái
  final List _sections = [
    {
      'label': 'HÔM NAY',
      'items': [
        {
          'id': '1',
          'title': '2 giờ trước',
          'message': 'Đơn hàng của bạn đang được vận chuyển',
          'isRead': false,
        },
        {
          'id': '2',
          'title': '2 giờ trước',
          'message': 'Mã giảm giá 20% dành cho bạn',
          'isRead': false,
        },
      ],
    },
    {
      'label': 'TRƯỚC ĐÓ',
      'items': [
        {
          'id': '3',
          'title': 'Hôm qua',
          'message': 'Thanh toán thành công cho đơn #2048',
          'isRead': true,
        },
        {
          'id': '4',
          'title': 'Hôm qua',
          'message': 'Bạn đã nhận được hàng thành công',
          'isRead': true,
        },
        {
          'id': '5',
          'title': '3 ngày trước',
          'message': 'Chúc mừng bạn đã có đơn hàng mới',
          'isRead': true,
        },
      ],
    },
  ];

  // Hàm làm mới danh sách (Kéo từ trên xuống)
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Logic làm mới dữ liệu nếu cần
    });
  }

  // Đánh dấu tất cả là đã đọc
  void _markAllAsRead() {
    setState(() {
      for (var section in _sections) {
        for (var item in section['items'] as List) {
          item['isRead'] = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.textPrimary,
        title: const Text(
          'Thông báo',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: AppColors.textPrimary),
            tooltip: 'Đánh dấu tất cả đã đọc',
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _sections.length,
          itemBuilder: (context, sectionIndex) {
            final section = _sections[sectionIndex];
            final items = section['items'] as List;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nhãn phân loại thời gian (Hôm nay, Trước đó,...)
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, top: 12),
                  child: Text(
                    section['label'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                      fontSize: 12,
                    ),
                  ),
                ),
                // Danh sách item trong nhóm
                ...items.map((item) {
                  final bool isRead = item['isRead'] as bool;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFE7ECF3),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: isRead
                            ? const Color(0xFFE2E8F0)
                            : AppColors.primary,
                        child: Icon(
                          Icons.notifications_outlined,
                          color: isRead ? AppColors.textSecondary : Colors.white,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        item['message'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      trailing: !isRead
                          ? Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.orange, // Chấm màu cam cho tin nhắn chưa đọc
                                shape: BoxShape.circle,
                              ),
                            )
                          : null,
                      onTap: () {
                        // Chạm vào để đổi trạng thái thành đã đọc ngay lập tức
                        setState(() {
                          item['isRead'] = true;
                        });
                      },
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}