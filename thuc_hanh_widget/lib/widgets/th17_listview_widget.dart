import 'package:flutter/material.dart';

class Th17ListviewWidget extends StatelessWidget {
  const Th17ListviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> monHoc = [
      {'ten': 'Lập trình di động', 'tc': 3},
      {'ten': 'Cơ sở dữ liệu', 'tc': 4},
      {'ten': 'Công nghệ phần mềm', 'tc': 3},
      {'ten': 'Lập trình Web', 'tc': 3},
      {'ten': 'Mạng máy tính', 'tc': 3},
      {'ten': 'Trí tuệ nhân tạo', 'tc': 3},
      {'ten': 'Kiểm thử phần mềm', 'tc': 2},
      {'ten': 'Đồ họa máy tính', 'tc': 3},
    ];
    // Sử dụng SizedBox giới hạn chiều cao để hiển thị gọn trong trang tổng
    return SizedBox(
      height: 250,
      child: ListView.separated(
        itemBuilder: (context, i) {
          return ListTile(
            leading: CircleAvatar(child: Text('${i + 1}')),
            title: Text(monHoc[i]['ten']),
            trailing: Text('${monHoc[i]['tc']} TC'),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: monHoc.length,
      ),
    );
  }
}
