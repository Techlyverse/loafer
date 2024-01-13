import 'package:flutter/material.dart';

class StatusBubble extends StatelessWidget {
  const StatusBubble({super.key, required this.isOnline});
  final bool isOnline;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 13,
      width: 13,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        shape: BoxShape.circle,
        border: Border.all(
            color: colorScheme.surface,
            width: 2.5,
            strokeAlign: BorderSide.strokeAlignCenter),
      ),
      child: CircleAvatar(backgroundColor: colorScheme.surface),
    );
  }
}
