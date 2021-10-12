import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class SpringChallenge extends StatefulWidget {
  const SpringChallenge({Key? key}) : super(key: key);

  @override
  _SpringChallengeState createState() => _SpringChallengeState();
}

class _SpringChallengeState extends State<SpringChallenge>
    with SingleTickerProviderStateMixin {
  late Spring _spring;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _spring = Spring(
      tickerProvider: this,
      springDescription: _springDescription,
    )..addListener(() {
        setState(() {});
      });
  }

  final _springDescription = const SpringDescription(
    mass: 1.0,
    stiffness: 500.0,
    damping: 15.0,
  );

  void _onTapUp(TapUpDetails details) {
    _spring
      ..anchorPosition = details.localPosition
      ..startSpring();
  }

  void _onPanStart(DragStartDetails details) {
    _spring.endSpring();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _spring.springPosition += details.delta;
  }

  void _onPanEnd(DragEndDetails details) {
    _spring.startSpring();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (timeStamp) {
          final box = context.findRenderObject() as RenderBox?;
          if (box != null && box.hasSize) {
            setState(
              () {
                _isInitialized = true;
                _spring.anchorPosition = box.size.center(Offset.zero);
                _spring.springPosition = _spring.anchorPosition;
              },
            );
          }
        },
      );
      return const SizedBox();
    }

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTapUp: _onTapUp,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: Stack(
          children: [
            const SpidermanBackground(),
            CustomPaint(
              painter: WebPainter(
                springPosition: _spring.springPosition,
                anchorPosition: _spring.anchorPosition,
              ),
              size: Size.infinite,
            ),
            Transform.translate(
              offset: _spring.springPosition,
              child: const FractionalTranslation(
                translation: Offset(-0.5, -0.5),
                child: DraggableSpiderman(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Spring with ChangeNotifier {
  Spring({
    required TickerProvider tickerProvider,
    required SpringDescription springDescription,
  })  : _springDescription = springDescription,
        _tickerProvider = tickerProvider;

  final SpringDescription _springDescription;
  final TickerProvider _tickerProvider;
  Ticker? _ticker;

  late SpringSimulation _springSimX;
  late SpringSimulation _springSimY;

  Offset _previousVelocity = Offset.zero;

  Offset get anchorPosition => _anchorPosition;
  Offset _anchorPosition = Offset.zero;

  set anchorPosition(Offset newAnchorPosition) {
    endSpring();
    _anchorPosition = newAnchorPosition;

    notifyListeners();
  }

  Offset get springPosition => _springPosition;
  Offset _springPosition = Offset.zero;
  set springPosition(Offset newSpringPosition) {
    endSpring();
    _springPosition = newSpringPosition;

    notifyListeners();
  }

  void startSpring() {
    _springSimX = SpringSimulation(
      _springDescription,
      springPosition.dx,
      _anchorPosition.dx,
      _previousVelocity.dx,
    );

    _springSimY = SpringSimulation(
      _springDescription,
      springPosition.dy,
      _anchorPosition.dy,
      _previousVelocity.dy,
    );

    _ticker ??= _tickerProvider.createTicker(_onTick);

    _ticker!.start();
  }

  void _onTick(Duration elapsedTime) {
    final elapsedSecondsFraction = elapsedTime.inMilliseconds / 1000.0;

    _springPosition = Offset(
      _springSimX.x(elapsedSecondsFraction),
      _springSimY.x(elapsedSecondsFraction),
    );

    _previousVelocity = Offset(
      _springSimX.dx(elapsedSecondsFraction),
      _springSimY.dx(elapsedSecondsFraction),
    );

    if (_springSimX.isDone(elapsedSecondsFraction) &&
        _springSimY.isDone(elapsedSecondsFraction)) {
      endSpring();
    }

    notifyListeners();
  }

  void endSpring() {
    if (_ticker != null) {
      _ticker!.stop();
    }
  }
}

class DraggableSpiderman extends StatelessWidget {
  const DraggableSpiderman({
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

class SpidermanBackground extends StatelessWidget {
  const SpidermanBackground({Key? key}) : super(key: key);

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

class WebPainter extends CustomPainter {
  WebPainter({
    required this.springPosition,
    required this.anchorPosition,
  });

  // distance
  final Offset springPosition;
  final Offset anchorPosition;

  final Paint springPaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      anchorPosition,
      springPosition,
      springPaint,
    );
  }

  @override
  bool shouldRepaint(WebPainter oldDelegate) {
    return anchorPosition != oldDelegate.anchorPosition ||
        springPosition != oldDelegate.springPosition;
  }
}
