/**
 * 45 phút
Hệ thống xếp loại sinh viên.
Class SinhVien với mã private,
họ tên, danh sách điểm. Có
getter tính điểm trung bình,
method xếp loại, override
toString() .
Trong main() tạo danh sách
sinh viên và dùng hàm bậc cao
để thống kê.
 */

class SinhVien {
  final String _maSV;
  String hoTen;
  List<double> dsDiem;

  SinhVien(this._maSV, this.hoTen, this.dsDiem);

  String get maSV => _maSV;
  double get diemTrungBinh {
    if (dsDiem.isEmpty) return 0.0;
    double tong = dsDiem.fold(0.0, (acc, d) => acc + d);
    return tong / dsDiem.length;
  }
  String xepLoai() {
    double dtb = diemTrungBinh;
    if (dtb >= 8.5) return 'Xuất sắc';
    if (dtb >= 8.0) return 'Giỏi';
    if (dtb >= 6.5) return 'Khá';
    if (dtb >= 5.0) return 'Trung bình';
    return 'Yếu';
  }

  @override
  String toString() {
    return 'SV: $hoTen [Mã: $_maSV] - ĐTB: ${diemTrungBinh.toStringAsFixed(2)} - Loại: ${xepLoai()}';
  }
}


void main() {
  List<SinhVien> danhSachSV = [
    SinhVien('SV01', 'Nguyễn Văn A', [8.5, 9.0, 8.0]),
    SinhVien('SV02', 'Trần Thị B', [6.0, 7.0, 6.5]),
    SinhVien('SV03', 'Lê Văn C', [4.0, 5.0, 3.5]),
    SinhVien('SV04', 'Phạm Minh D', [9.5, 9.0, 9.8]),
  ];

  print('--- DANH SÁCH SINH VIÊN ---');
  danhSachSV.forEach((sv) => print(sv));

  print('\n--- THỐNG KÊ (HÀM BẬC CAO) ---');
  var svGioi = danhSachSV.where((sv) => sv.diemTrungBinh >= 8.0).toList();
  print('Số sinh viên Giỏi/Xuất sắc: ${svGioi.length}');

  // Lấy danh sách tên các sinh viên đạt (map)
  var tenSVDat = danhSachSV
      .where((sv) => sv.diemTrungBinh >= 5.0)
      .map((sv) => sv.hoTen)
      .toList();
  print('Danh sách SV đạt:');
  tenSVDat.forEach((sv) => print(sv));
} 