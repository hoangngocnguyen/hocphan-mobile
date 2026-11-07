import 'dart:async'; // Cần import để dùng Timer cho auto-play

import 'package:flutter/material.dart';

void main() {
  runApp(const SliderPage());
}

class SliderPage extends StatelessWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complicated image slider demo (No Library)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF29B6F6)),
        useMaterial3: true,
      ),
      home: const ComplicatedImageSliderDemo(),
    );
  }
}

class ComplicatedImageSliderDemo extends StatefulWidget {
  const ComplicatedImageSliderDemo({super.key});

    @override
    State<ComplicatedImageSliderDemo> createState() =>
        _ComplicatedImageSliderDemoState();
}

class _ComplicatedImageSliderDemoState
    extends State<ComplicatedImageSliderDemo> {
  static const Duration _slideInterval = Duration(seconds: 3);

  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9wKd9TSpayxejDlCQexW66D-4ofXQOgL3nFfqtYUwdg&s=10',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPTwCnSUeJYG2EzZRih5eJehJlscviQ-iqnrrBeFmVHg&s=10',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqqJYy9zPBesa1wj-gk4oRZMC1C6uc9ffZuxtfDwcnmQ&s=10',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSR85rt1WHzJrqvvUUlX-2glkQ-B7MBNkTUCVbsRCQiww&s=10',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY6HJ6XxDObt5pxY1FTM0u0y_pfGA5UcjuOnuda77ZVA&s=10',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqZyj_4XEo8IYo0dsJRmyGfudpEY2AhqDCHs2RYu7sgw&s=10',
  ];

  int _current = 0;
  late final PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // viewportFraction: 0.8 giúp nhìn thấy một phần ảnh kế tiếp (tương tự enlargeCenterPage của thư viện)
    _pageController = PageController(viewportFraction: 0.8);

    // Thiết lập tự động chạy (Auto-play)
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(_slideInterval, (timer) {
      if (_pageController.hasClients) {
        int nextPage = _current + 1;
        if (nextPage >= imgList.length) {
          nextPage = 0; // Quay về ảnh đầu tiên khi hết list
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hủy timer khi widget bị hủy để tránh rò rỉ bộ nhớ
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 118, 207),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {},
        ),
        title: const Text(
          'Slide ảnh phong cảnh',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              // Thay thế CarouselSlider bằng SizedBox kết hợp PageView.builder chuẩn Flutter
              SizedBox(
                height: 220, // Đặt chiều cao cố định cho khung slide (tỷ lệ tương ứng)
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imgList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = imgList[index];

                    // Hiệu ứng phóng to nhẹ trang đang hiển thị (mô phỏng enlargeCenterPage)
                    bool isCurrent = _current == index;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: isCurrent
                            ? 0.0
                            : 10.0, // Thu nhỏ nhẹ các ảnh phụ xung quanh
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            // 1. Ảnh nền từ mạng
                            Image.network(
                              item,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey.shade300,
                                    child: const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                            ),
                            // 2. Lớp phủ Gradient đen mờ và chữ ở chân ảnh
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(210, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  'No. $index image',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Dấu tròn vị trí ảnh (Indicator)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return Container(
                    width: _current == entry.key ? 20.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: _current == entry.key
                          ? const Color(0xFF0288D1)
                          : Colors.grey.shade400,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
