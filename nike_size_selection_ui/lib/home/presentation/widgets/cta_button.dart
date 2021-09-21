import 'package:flutter/material.dart';

class CtaButton extends StatefulWidget {
  const CtaButton({
    Key? key,
    required this.title,
    required this.onCtaTap,
  }) : super(key: key);

  final String title;
  final Function(bool) onCtaTap;

  @override
  _CtaButtonState createState() => _CtaButtonState();
}

class _CtaButtonState extends State<CtaButton> {
  String get _title => widget.title;
  Function get _onCtaTap => widget.onCtaTap;
  bool _isTapped = false;

  BoxDecoration _getDecoration() {
    if (_isTapped) {
      return BoxDecoration(
        color: const Color(0xFFFF2D4C),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2.5),
            color: Colors.red.shade600,
            blurRadius: 10,
          ),
        ],
      );
    } else {
      return BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        borderRadius: BorderRadius.circular(32),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.red,
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
        });

        _onCtaTap(_isTapped);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        height: 40,
        width: 150,
        decoration: _getDecoration(),
        child: Center(
          child: Text(
            _title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
