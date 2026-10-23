import 'package:flutter/material.dart';

class Th10ImageWidget extends StatelessWidget {
  const Th10ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        'https://picsum.photos/400/300',
        width: 300,
        height: 200,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
          );
        },
      ),
    );
  }
}
