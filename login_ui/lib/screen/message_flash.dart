import 'package:flutter/material.dart';

class MessageFlash extends StatefulWidget {
  const MessageFlash({
    Key? key,
    required this.flashId,
    required this.color,
    required this.child,
  }) : super(key: key);

  final String flashId;
  final Color color;
  final Widget child;

  @override
  State<MessageFlash> createState() => _MessageFlashState();
}

class _MessageFlashState extends State<MessageFlash>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _flash();
    super.initState();
  }

  void _flash() {
    _fadeController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Container(
            width: double.infinity,
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(1.0 - _fadeController.value),
              borderRadius: BorderRadius.circular(8),
            ),
            child: child);
      },
      child: Center(
        child: widget.child,
      ),
    );
  }
}
