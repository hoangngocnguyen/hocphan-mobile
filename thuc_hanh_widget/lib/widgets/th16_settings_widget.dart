import 'package:flutter/material.dart';

class Th16SettingsWidget extends StatefulWidget {
  const Th16SettingsWidget({super.key});

  @override
  State<Th16SettingsWidget> createState() => _Th16SettingsWidgetState();
}

class _Th16SettingsWidgetState extends State<Th16SettingsWidget> {
  bool _nhoDangNhap = false;
  bool _nhanThongBao = true;
  double _coChu = 16;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile(
          title: const Text('Nhớ đăng nhập'),
          value: _nhoDangNhap,
          onChanged: (v) => setState(() => _nhoDangNhap = v ?? false),
        ),
        SwitchListTile(
          value: _nhanThongBao,
          onChanged: (v) => setState(() {
            _nhanThongBao = v;
          }),
          title: const Text('Nhận thông báo'),
        ),
        Slider(
          value: _coChu,
          onChanged: (v) => setState(() => _coChu = v),
          min: 12,
          max: 18,
          divisions: 16,
          label: _coChu.round().toString(),
        ),
        const SizedBox(height: 8),
        Text('Chữ mẫu xem trước', style: TextStyle(fontSize: _coChu)),
      ],
    );
  }
}
