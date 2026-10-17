import 'dart:async';

void main() async {
  print('==================================================');
  print('🚀 BẮT ĐẦU CHƯƠNG TRÌNH - VÒNG LẶP SỰ KIỆN (EVENT LOOP)');
  print('==================================================\n');

  // ----------------------------------------------------
  // PHẦN 1: XỬ LÝ FUTURE BẰNG ASYNC / AWAIT (CƠ BẢN)
  // ----------------------------------------------------

  print('--- Part1: Gọi API lấy danh sách dữ liệu ---');
  try {
    // dùng await để dừng mọi thứ, gọi API xong rồi mới làm tiếp
    List<String> songList = await layDanhSachSong('Karaoke');
    print('API response: $songList\n');
  } catch (e) {
    print('Có lỗi xảy ra: $e\n');
  }

  // ----------------------------------------------------
  // PHẦN 2: CHẠY NHIỀU FUTURE SONG SONG BẰNG Future.wait()
  // ----------------------------------------------------
  print('--- [Phần 2] Chạy song song nhiều tác vụ độc lập ---');
  // Stopwatch stopwatch = Stopwatch()..start();

  // // Không dùng await lẻ từng cái (sẽ mất 1s + 1s + 1s = 3s).
  // // Dùng Future.wait để khởi chạy cả 3 tác vụ CÙNG LÚC.
  // // Tổng thời gian chỉ bằng thời gian của tác vụ lâu nhất (~1 giây).
  // List<dynamic> ketQuaSongSong = await Future.wait([
  //   taiGiaTien(),
  //   taiDanhMuc(),
  //   taiQuangCao(),
  // ]);

  // stopwatch.stop();
  // print('✅ Kết quả thu được: $ketQuaSongSong');
  // print(
  //   '⏱️  Tổng thời gian xử lý song song: ${stopwatch.elapsedMilliseconds}ms (Tối ưu gấp 3 lần chạy tuần tự!)\n',
  // );

  Stopwatch stopwatch = Stopwatch()
    ..start(); // bấm giờ, '..' nghĩa là vừa khởi tạo, vừa gọi stopwatch.start()

  // Khởi chạy 3 tiến trình 1 lúc, time_total = max(time1, time2, time3)
  List<dynamic> ketQuaSongSong = await Future.wait([
    taiGiaTien(),
    taiDanhMuc(),
    taiQuangCao(),
  ]); // ánh xạ 3 kết quả vào List

  stopwatch.stop();
  print('✅ Kết quả thu được: $ketQuaSongSong');
  print('Tổng thời gian xử lý song song là: ${stopwatch.elapsedMilliseconds}');

  // ----------------------------------------------------
  // PHẦN 3: XỬ LÝ DÒNG DỮ LIỆU THEO THỜI GIAN (STREAM)
  // sử dụng khi muốn cập nhật tiến trình tải cho người dùng biết
  // ----------------------------------------------------
  print('--- [Phần 3] Lắng nghe Stream real-time (Tiến trình tải) ---');

  // Tạo StreamGenerator phát dữ liệu từ 1 -> 5, mỗi 300ms phát 1 lần
  Stream<int> tienTrinhStream = taoTienTrinhTai(5);

  // 'await for' được dùng để lắng nghe từng giá trị phát ra từ Stream theo thời gian
  await for (int phanTram in tienTrinhStream) {
    print('⏳ Tiến trình tải xuống: ${phanTram * 20}%');
  }
  print('🎉 Hoàn tất nhận dữ liệu từ Stream!\n');

  // ----------------------------------------------------
  // PHẦN 4: STREAM CONTROLLER (TẠO STREAM THỦ CÔNG)
  // ----------------------------------------------------
  print('--- [Phần 4] Quản lý Stream bằng StreamController ---');

  // Tạo một bộ điều khiển StreamController (quản lý luồng dữ liệu)
  final controller = StreamController<String>();

  // Đăng ký listener (người nghe) sự kiện trên controller đó.
  final subscription = controller.stream.listen(
    (duLieuMoi) =>
        print('📩 [Stream Event]: Nhận thông báo mới -> "$duLieuMoi"'),
    onError: (loi) => print('⚠️ [Stream Error]: $loi'),
    onDone: () => print('🏁 StreamController đã đóng an toàn.'),
  );

  // Bắt đầu đẩy dữ liệu vào Stream
  controller.add('Có bài hát mới được thêm vào danh sách!');
  await Future.delayed(Duration(milliseconds: 200));

  controller.add('Người dùng vừa nhấn nút Like!');
  await Future.delayed(Duration(milliseconds: 200));

  // QUAN TRỌNG: Luôn dọn dẹp Stream và Subscription khi hoàn thành để tránh LỌC BỘ NHỚ (Memory Leak)
  await controller.close();
  await subscription.cancel();

  print('\n==================================================');
  print('🏁 KẾT THÚC TOÀN BỘ BÀI TEST BẤT ĐỒNG BỘ');
  print('==================================================');
}

// ============================================================================
// CÁC HÀM PHỤ TRỢ (MÔ PHỎNG TÁC VỤ MẠNG & THỜI GIAN THỰC)
// ============================================================================

/// 1. Hàm trả về Future<T>: Giả lập gọi API lấy dữ liệu mất 1.5 giây
Future<List<String>> layDanhSachSong(String tenApp) async {
  // Duration mô phỏng độ trễ của mạng internet
  await Future.delayed(const Duration(milliseconds: 1500));

  if (tenApp.isEmpty) {
    throw ArgumentError('Tên ứng dụng không được để rỗng!');
  }

  return ['Bài hát A', 'Bài hát B', 'Bài hát C'];
}

/// 2. Các hàm độc lập dùng cho Future.wait()
Future<String> taiGiaTien() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Giá: 100k';
}

Future<String> taiDanhMuc() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Danh mục: Pop';
}

Future<String> taiQuangCao() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Banner: Giảm giá 50%';
}

/// 3. Hàm trả về Stream<T> bằng 'async*' và từ khóa 'yield'
/// Dùng khi bạn muốn phát ra MỘT CHUỖI giá trị theo thời gian (chứ không phải 1 giá trị duy nhất như Future)
/// Stream: Dòng dữ liệu theo thời gian:
/// Nếu một hàm bình thường dùng async và trả về future --> trả về 1 response duy nhất và kết thúc.
/// Hàm này dùng async* (viết tắt của asynchronous generator): Cho phép hàm này sinh ra một chuỗi nhiều giá trị "xuất hiện dần" theo thời gian.
///
Stream<int> taoTienTrinhTai(int maxSteps) async* {
  for (int i = 1; i <= maxSteps; i++) {
    await Future.delayed(const Duration(milliseconds: 300)); // delay
    yield i; // 'yield' tương tự như return, nhưng không dừng hàm mà tiếp tục chạy vòng lặp phát ra giá trị tiếp theo
  }
}
