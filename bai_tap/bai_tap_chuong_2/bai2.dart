/**
 * Mô hình OOP cho hệ thống
quản lý kho hàng.
Vận dụng abstract class, kế
thừa, implements và mixin để
thiết kế cấu trúc lớp cho các
loại hàng hóa khác nhau.
 */

abstract class HangHoa {
  final String maHang;
  String tenHang;
  double giaCoBan;

  HangHoa({required this.maHang, required this.tenHang, required this.giaCoBan});

  double tinhGiaBan();

  void getInfo() {
    print('Mã: $maHang | Tên: $tenHang | Giá bán: ${tinhGiaBan()} VNĐ');
  }
}


abstract class CoTheLuuKho {
  void kiemTraTonKho();
}

mixin ThueVAT {
  double tinhThue(double gia, double phanTram) {
    return gia * (phanTram/100);
  }
}

class HangDienMay extends HangHoa with ThueVAT implements CoTheLuuKho {
  int thoiGianBaoHanhThang;

  HangDienMay({
    required super.maHang,
    required super.tenHang,
    required super.giaCoBan,
    required this.thoiGianBaoHanhThang,
  });


  @override
  void kiemTraTonKho() {
    print('Đang kiểm tra tồn kho điện máy cho mặt hàng: $tenHang...');
  }

  @override
  double tinhGiaBan() {
    return giaCoBan + tinhThue(giaCoBan, 10.0);
  }
}


void main() {
  HangDienMay tivi = HangDienMay(
    maHang: 'DM01',
    tenHang: 'Tivi Samsung 4K 55 inch',
    giaCoBan: 10000000,
    thoiGianBaoHanhThang: 24,
  );

  tivi.getInfo();
  tivi.kiemTraTonKho();
}