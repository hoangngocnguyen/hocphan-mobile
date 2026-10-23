import 'package:flutter/material.dart';

class Th15TextfieldWidget extends StatefulWidget {
  const Th15TextfieldWidget({super.key});

  @override
  State<Th15TextfieldWidget> createState() => _Th15TextfieldWidgetState();
}

class _Th15TextfieldWidgetState extends State<Th15TextfieldWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // giải phóng controller khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          onChanged: (_) => setState(() {}), // cập nhật khi gõ
          decoration: InputDecoration(
            labelText: 'Họ và tên',
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _controller.text.isEmpty
              ? 'Bạn chưa nhập tên.'
              : 'Xin chào, ${_controller.text}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
