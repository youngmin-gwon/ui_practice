import 'package:flutter/material.dart';

class BouncingButton extends StatefulWidget {
  const BouncingButton({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.borderRadius = 2.0,
    this.onPressed,
  });

  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback? onPressed;

  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    )..addListener(() {
        setState(() {});
      });

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: _AnimatedButton(
          borderRadius: widget.borderRadius,
          backgroundColor: widget.backgroundColor,
          child: widget.child,
        ),
      ),
    );
  }
}

class _AnimatedButton extends StatelessWidget {
  const _AnimatedButton({
    this.borderRadius = 2.0,
    required this.backgroundColor,
    required this.child,
  });

  final double borderRadius;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 12.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
