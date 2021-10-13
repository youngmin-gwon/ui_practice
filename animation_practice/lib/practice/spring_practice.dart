import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class SpringPractice extends StatefulWidget {
  const SpringPractice({Key? key}) : super(key: key);

  @override
  _SpringPracticeState createState() => _SpringPracticeState();
}

class _SpringPracticeState extends State<SpringPractice>
    with SingleTickerProviderStateMixin {
  final _springDescription =
      const SpringDescription(mass: 1.0, stiffness: 500.0, damping: 15.0);

  late SpringSimulation _springSimX;
  late SpringSimulation _springSimY;

  Offset _springPosition = Offset.zero;
  Offset? _anchorPosition;

  Offset _previousVelocity = Offset.zero;

  Ticker? _ticker;

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _anchorPosition = details.localPosition;
      _endSpring();
      _startSpring();
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _springPosition += details.delta;
    });
  }

  void _onPanStart(DragStartDetails details) {
    _endSpring();
  }

  void _onPanEnd(DragEndDetails details) {
    _startSpring();
  }

  void _startSpring() {
    _springSimX = SpringSimulation(
      _springDescription,
      _springPosition.dx,
      _anchorPosition!.dx,
      _previousVelocity.dx,
    );

    _springSimY = SpringSimulation(
      _springDescription,
      _springPosition.dy,
      _anchorPosition!.dy,
      _previousVelocity.dy,
    );

    _ticker ??= createTicker(_onTick);

    _ticker!.start();
  }

  void _onTick(Duration elapsedTime) {
    final elapsedTimeFraction = elapsedTime.inMilliseconds / 1000.0;

    setState(() {
      _springPosition = Offset(
        _springSimX.x(elapsedTimeFraction),
        _springSimY.x(elapsedTimeFraction),
      );

      _previousVelocity = Offset(
        _springSimX.dx(elapsedTimeFraction),
        _springSimY.dx(elapsedTimeFraction),
      );
    });

    if (_springSimX.isDone(elapsedTimeFraction) &&
        _springSimY.isDone(elapsedTimeFraction)) {
      _endSpring();
    }
  }

  void _endSpring() {
    _ticker?.stop();
  }

  @override
  Widget build(BuildContext context) {
    if (_anchorPosition == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        // we only can look this up after first build, not before first build.

        // RenderBox is the actual run-time representation of widget
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          setState(() {
            _anchorPosition = box.size.center(Offset.zero);
            _springPosition = _anchorPosition!;
          });
        }
      });

      return const SizedBox();
    }

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTapUp: _onTapUp,
        onPanUpdate: _onPanUpdate,
        onPanStart: _onPanStart,
        onPanEnd: _onPanEnd,
        child: Stack(
          children: [
            const SpidermanPracticeBackground(),
            CustomPaint(
              size: Size.infinite,
              painter: WebPracticePainter(
                anchorPosition: _anchorPosition!,
                springPosition: _springPosition,
              ),
            ),
            FractionalTranslation(
              translation: const Offset(-0.5, -0.5),
              child: Transform.translate(
                  offset: _springPosition, child: const SpidermanDraggable()),
            )
          ],
        ),
      ),
    );
  }
}

class SpidermanPracticeBackground extends StatelessWidget {
  const SpidermanPracticeBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        "assets/sky_scrapper_windows.jpg",
        fit: BoxFit.cover,
        color: Colors.black.withOpacity(.6),
        colorBlendMode: BlendMode.multiply,
      ),
    );
  }
}

class SpidermanDraggable extends StatelessWidget {
  const SpidermanDraggable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Image.asset("assets/spiderman.png"),
    );
  }
}

class WebPracticePainter extends CustomPainter {
  const WebPracticePainter({
    required this.springPosition,
    required this.anchorPosition,
  });

  final Offset springPosition;
  final Offset anchorPosition;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    canvas.drawLine(anchorPosition, springPosition, paint);
  }

  @override
  bool shouldRepaint(WebPracticePainter oldDelegate) {
    return springPosition != oldDelegate.springPosition ||
        anchorPosition != oldDelegate.anchorPosition;
  }
}
