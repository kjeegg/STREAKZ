// lib/widgets/placeholder_image.dart

import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  final String placeholderName;

  const PlaceholderImage({Key? key, required this.placeholderName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.3),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Заглушка: $placeholderName',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
