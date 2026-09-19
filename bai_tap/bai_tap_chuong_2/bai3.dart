import 'dart:async';

/**
 * Hệ thống bất đồng bộ, giỏ hàng
thời gian thực.
Kết hợp Future , Stream ,
StreamController và xử lý lỗi
đầy đủ để mô phỏng luồng cập
nhật giỏ hàng.
 */

class SanPhamGioHang {
  final String id;
  final String ten;
  int soLuong;
  double gia;

  SanPhamGioHang(this.id, this.ten, this.soLuong, this.gia);
}

class QuanLyGioHang {
  final List<SanPhamGioHang> _danhSach = [];

  // Khởi tạo Stream Controller
  final StreamController<List<SanPhamGioHang>> _controller =
      StreamController<List<SanPhamGioHang>>.broadcast();

  Stream<List<SanPhamGioHang>> get streamGioHang => _controller.stream;

  // Giả lập gọi API
  Future<bool> _kiemTraKhoAPI(String idSanPham, int soLuong) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (soLuong > 10) {
      throw Exception('Số lượng sản phẩm trong kho không đủ (Tối đa 10)!');
    }

    return true;
  }

  // Thêm sản phẩm
  Future<void> themSanPham(SanPhamGioHang sp) async {
    try {
      print('--> Đang kiểm tra tồn kho cho: ${sp.ten}...');
      await _kiemTraKhoAPI(sp.id, sp.soLuong);

      _danhSach.add(sp);
      print('--> Thêm thành công!');

      // Thêm ds vào Stream
      _controller.sink.add(List.from(_danhSach));
    } catch (e) {
      print('[LỖI]: $e');
    }
  }

  void dondep() {
    _controller.close(); // Đóng stream khi xong
  }
}

void main() async {
  QuanLyGioHang gioHang = QuanLyGioHang();

  // Đăng ký lắng nghe sự thay đổi của giỏ hàng (Stream)
  gioHang.streamGioHang.listen((danhSachSp) {
    double tongTien = danhSachSp.fold(
      0,
      (sum, item) => sum + (item.gia * item.soLuong),
    );
    print(
      '[CẬP NHẬT GIỎ HÀNG] Tổng số món: ${danhSachSp.length} | Tổng tiền: $tongTien VNĐ',
    );
  });

  // Thực hiện thêm các sản phẩm
  await gioHang.themSanPham(SanPhamGioHang('SP01', 'Áo thun', 2, 150000));
  await gioHang.themSanPham(SanPhamGioHang('SP02', 'Quần Jeans', 1, 350000));

  await gioHang.themSanPham(SanPhamGioHang('SP03', 'Giày Sneaker', 15, 800000));

  gioHang.dondep();
}
