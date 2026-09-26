// Nguyễn Ngọc Huy Hoàng 23T1080015

import 'dart:io';

void main() {
  List<double> danhSachDiem = [];

  // 1. Nhập số lượng điểm
  stdout.write('Nhập số lượng sinh viên: ');
  int soLuong = int.parse(stdin.readLineSync()!);

  // 2. Nhập điểm từng sinh viên
  for (int i = 0; i < soLuong; i++) {
    stdout.write('Nhập điểm sinh viên ${i + 1}: ');
    double diem = double.parse(stdin.readLineSync()!);
    danhSachDiem.add(diem);
  }

  if (danhSachDiem.isEmpty) {
    print('Danh sách điểm trống!');
    return;
  }

  // 3. Tính tổng và dtb
  var tong = danhSachDiem.reduce((tong, diem) => tong + diem);
  print('\nTong: $tong');

  var dtb = tong / danhSachDiem.length;
  print('Diem Trung Binh: ${dtb.toStringAsFixed(2)}');

  // 4. Tìm max min
  var maxDiem = danhSachDiem.reduce((max, diem) => max > diem ? max : diem);
  var minDiem = danhSachDiem.reduce((min, diem) => min < diem ? min : diem);
  print('Diem cao nhat: $maxDiem');
  print('Diem thap nhat: $minDiem');

  // 5. Thống kê phổ
  List<int> phoDiem = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  for (double diem in danhSachDiem) {
    if (diem >= 0 && diem <= 10) {
      int index = diem.floor();
      phoDiem[index]++;
    }
  }

  // 6. Vẽ
  print('\n---THỐNG KÊ PHỔ ĐIỂM---');
  for (int i = 0; i <= 10; i++) {
    String khoangDiem = (i == 10) ? '[10]' : '[$i - ${i + 1})';
    String bieuDo = '*' * phoDiem[i];
    print('${khoangDiem.padRight(9)}: ${phoDiem[i].toString().padLeft(2)} | $bieuDo');
  }
}