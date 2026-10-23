import 'package:flutter/material.dart';

class Th12CounterStateWidget extends StatefulWidget {
  const Th12CounterStateWidget({super.key});

  @override
  State<Th12CounterStateWidget> createState() => _Th12CounterStateWidgetState();
}

class _Th12CounterStateWidgetState extends State<Th12CounterStateWidget> {
  int _counter = 0;
  void _giam() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _tang() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$_counter',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: _counter % 2 == 0 ? Colors.green : Colors.orange,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _counter > 0 ? _giam : null,
              label: const Text('Giảm'),
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _tang,
              label: const Text('Tăng'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
