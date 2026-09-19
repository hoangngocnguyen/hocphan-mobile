void main() {
  // test1();
  // test2();

  // test3();

  test4();
  
}

void test1() {
  print("Xin chào, Flutter!");

  var ten = 'Nguyễn Văn A';
  final thoiGianDangNhap = DateTime.now();
  final danhSach = [1,2,3];
  const maxSize = 100;

  int soLuong =1500;
  double gia = 299.99;

  double soThuc = 7.toDouble();
  int phan = 7.8.toInt();
  int lamTron = 7.8.round();

  String hoTen = 'Nguyễn Văn An';
  int tuoi = 21;
  double gpa = 3.75;

  print('Sinh viên $hoTen, $tuoi tuổi');

  print('GPA: ${gpa.toStringAsFixed(2)}');
  
  String duongDan = r'flutter_application_1\lib\practices\tuan2.dart';
  print(duongDan);
}

void test2() {
  var dai = 5.0;
  var rong = 7.0;
  var s1 = tinhDienTich(dai, rong);
  var s2 = tinhDienTich2(dai, rong);
  hienThiThongBao('S = $s1 = $s2');
}

void test3() {
  // 1. Gán hàm cho biến
  int Function(int, int) phepTinh = (a,b) => a +b;
  print(phepTinh(5,5));

  phepTinh = (a, b) => a*b;   // thay bằng hàm khác cùng kiểu
  print(phepTinh(5,5));

  // 2. Truyền hàm làm tham số:
  List<int> locDanhSach(List<int> ds, bool Function(int) dieuKien) {
    return ds.where(dieuKien).toList();
  }

  var soLe = locDanhSach([1,2,3,4,5], (x) => x%2 == 1);

  print(soLe);


  // Lọc danh sách số nguyên tố
  var soNguyenTo = locDanhSach([1,2,3,4,5,6,7,8,9], (x) {
    if (x < 2)  return false;

    for (int i = 2; i * i <= x; i++) {
      if (x % i == 0) return false;
    }
    return true;
  });

  hienThiThongBao(soNguyenTo.toString());

  // 3. Trả về hàm từ hàm, tạo hàm "cấu hình sẵn"
  // Higher-Order Functions (Hàm bậc cao) và Closure trong Dart
  bool Function(int) taoBoLoc(int nguong) => (x) => x > nguong;
  var locLon3 = taoBoLoc(3);
  print(locLon3(5));
  
  /*
  - bool Function(int): Kiểu dữ liệu trả về của hàm taoBoLoc là một hàm
  - taoBoLoc(int nguong): tên hàm taoBoLoc cùng với tham số đầu vào
  - hàm taoBoLoc nó trả về hàm (x) => x > nguong.
  */ 

}


void test4() {
  // NULL Safety
  /**
   * Hạn chế tối đa ứng dụng crash vì giá trị null
   */

  String ten; // trình biên dịch đảm bảo nó không được null -> Nó sẽ báo khi biên dịch (JAVA thì vẫn cho biên dịch khi null)


  // 1. Toán tử ?: gọi phương thức an toàn
  String? email;  // có thể null
  int? doDai = email?.length; // nếu email null => doDai null.

  // 2. Toán tử ?? giá trị mặc định (null coalescing)
  String? tenDangNhap;
  String tenHienThi = tenDangNhap ?? ' Khách';
  // cache ?? = getDataFromServer(); // chỉ gọi nếu cache đang null (nếu cache null thì lấy getData, không thì giữ nguyên)
  
  // 3. Toán tử ! khẳng định không null (hạn chế sử dụng)
  /*
   String link = duongLink!;  
   // duongLink có thể null, != null. (!: nếu duongLink = null thì crash) 
   //=> nói với trình biên dịch để nó không báo lỗi khi biên dịch => Chỉ crash khi chạy ứng dụng.
  */

  // 4. Toán tử late, khởi tạo trễ
  late String tenNguoiDung;   // biết là cần khởi tạo, nhưng chưa biết khởi tạo với giá trị gì

  // ...5
  taoNguoiDung(ten: "Hoang Nguyen", email: "abc@gmail.com", tuoi: 20);
  taoNguoiDung(email: "hn@a.com", ten: "Ha");
}

// 5. Named parameters - tham số được đặt tên (ghi tham số khi truyền để rõ ràng)

// để ý dấu ngoặc nhọn
void taoNguoiDung({
  required String ten,
  required String email,
  int tuoi = 18,
  String? soDienThoai,
}) {
  print('Tạo người dùng: $ten ($email), $tuoi tuoi, ${soDienThoai?? 'Chưa có sđt'}');
}


///////
/// Xây dựng hàm
double tinhDienTich(double chieuDai, double chieuRong) {
  return chieuDai * chieuRong;
}

void hienThiThongBao(String thongBao) {
  print('[Thông báo] $thongBao');
}

double tinhDienTich2(double d, double r) => d* r;
