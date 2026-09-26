void list() {
  List<String> danhMuc = ['Điện tử', 'Thời trang', 'Sách'];
  var soNguyen = [1, 2, 3, 4, 5];
  var rong = <double>[];
  print(soNguyen);
  print(rong);

  // Truy cập
  print(danhMuc[0]);
  print(danhMuc.first);
  print(danhMuc.length);

  // Thêm và xóa
  danhMuc.add('Đồ gia dụng');
  danhMuc.insert(1, 'Thực phẩm');
  danhMuc.addAll(['Sức khỏe', 'Thể thao']);
  danhMuc.remove('Sách');
  danhMuc.removeAt(0);

  // Tìm kiếm
  if (danhMuc.contains('Điện tử')) {
    print('Danh mục có chứa Điện tử');
  } else {
    print('Danh mục không chứa Điện tử');
  }
  int viTri = danhMuc.indexOf('Thời trang');
}

void listOperator() {
  // Spread
  // Null-aware spread
  // Collection if, for (thêm phần tử vào list bằng điều kiện)

  print('\n--- Một số toán tử trong list');
  List<String> sanPhamNoiBat = ['Điện thoại', 'Laptop', 'Máy tính bảng'];
  var phuKien = ['Tai nghe', 'Sạc dự phòng'];

  // Nối danh sách
  var danhSachSanPham = [...sanPhamNoiBat, 'Bàn phím', ...phuKien, 'Chuột'];
  print(danhSachSanPham);

  var vip = true;
  var danhSachSanPhamVip = [
    ...sanPhamNoiBat,
    if (vip) 'Nhẫn kim cương',
    ...phuKien,
  ];
  print(danhSachSanPhamVip);

  // Set, ánh xạ (tìm hiểu)
}

void listHighLevel() {
  List<double> diemSo = [6, 7, 8, 8.4, 5.6, 9, 9.3];
  print(diemSo);
  List<String> ketQua = diemSo
      .map((diem) => diem >= 8 ? 'Giỏi' : 'Chưa giỏi')
      .toList();
  print(ketQua);

  var hocBong = diemSo.where((diem) => diem >= 8.0).toList();
  print(hocBong);

  // Reduce
  var tongDiem = diemSo.reduce((tong, diem) => tong + diem);
  print(tongDiem);
}

void baitap1() {
  // Nhập danh sách điểm các sinh viên 1 lớp
  /**
   * Tính tổng
   * DTB
   * Điểm cao nhất
   * Điểm thấp nhất
   * Thống kê phổ điểm: điểm - phổ
   * Vẽ phổ điểm: (dấu * theo số lượng)
   */
}
