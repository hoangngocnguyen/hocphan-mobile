import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart'; // Đảm bảo đường dẫn chuẩn tới file chứa AppColors của bạn

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Khóa định danh cho Form để check validate email
  final _formKey = GlobalKey<FormState>();
  
  // Controller để lấy dữ liệu người dùng nhập ở ô email
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitResetPassword() {
    if (_formKey.currentState!.validate()) {
      // Lấy dữ liệu email người dùng vừa nhập
      final email = _emailController.text.trim();
      
      // Xử lý logic gửi yêu cầu khôi phục mật khẩu ở đây (gọi API / Firebase)
      
      // Hiện thông báo thành công tạm thời
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã gửi hướng dẫn khôi phục tới: $email'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Sau khi gửi thành công có thể cho quay về trang Login
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khôi phục mật khẩu'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Nhập email đã đăng ký của bạn. Chúng tôi sẽ gửi liên kết để đặt lại mật khẩu.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 32),

                // Ô nhập Email (Field)
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Nhập địa chỉ email của bạn',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email của bạn';
                    }
                    // Kiểm tra định dạng email cơ bản
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return 'Định dạng email không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Nút Gửi yêu cầu khôi phục
                ElevatedButton(
                  onPressed: _submitResetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Gửi yêu cầu khôi phục',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}