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
  final _springDescription = const SpringDescription(
    mass: 1.0,
    stiffness: 500,
    damping: 15,
  );

  late SpringPr _spring;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _spring = SpringPr(
      tickerProvider: this,
      springDescription: _springDescription,
    )..addListener(() {
        setState(() {});
      });
  }

  void _onTapUp(TapUpDetails details) {
    _spring
      ..anchorPosition = details.localPosition
      ..startSpring();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _spring.springPosition += details.delta;
  }

  void _onPanStart(DragStartDetails details) {
    _spring.endSpring();
  }

  void _onPanEnd(DragEndDetails details) {
    _spring.startSpring();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      WidgetsBinding.instance!.scheduleFrameCallback((_) {
        final _box = context.findRenderObject() as RenderBox?;
        if (_box != null && _box.hasSize) {
          _isInitialized = true;
          _spring.anchorPosition = _box.size.center(Offset.zero);
          _spring.springPosition = _spring.anchorPosition;
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
        child: Stack(children: [
          const SpidermanPracticeBackground(),
          CustomPaint(
            size: Size.infinite,
            painter: WebPracticePainter(
              anchorPosition: _spring.anchorPosition,
              springPosition: _spring.springPosition,
            ),
          ),
          FractionalTranslation(
            translation: const Offset(-0.5, -0.5),
            child: Transform.translate(
              offset: _spring.springPosition,
              child: const SpidermanPiece(),
            ),
          )
        ]),
      ),
    );
  }
}

class SpidermanPiece extends StatelessWidget {
  const SpidermanPiece({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: Image.asset(
        "assets/spiderman.png",
      ),
    );
  }
}

class SpringPr with ChangeNotifier {
  SpringPr(
      {required TickerProvider tickerProvider,
      required SpringDescription springDescription})
      : _springDescription = springDescription,
        _tickerProvider = tickerProvider;

  final SpringDescription _springDescription;
  final TickerProvider _tickerProvider;

  Ticker? _ticker;

  late SpringSimulation _springSimX;
  late SpringSimulation _springSimY;

  Offset _anchorPosition = Offset.zero;

  Offset get anchorPosition => _anchorPosition;
  set anchorPosition(Offset newAnchorPosition) {
    endSpring();
    _anchorPosition = newAnchorPosition;

    notifyListeners();
  }

  Offset _springPosition = Offset.zero;
  Offset get springPosition => _springPosition;
  set springPosition(Offset newSpringPosition) {
    endSpring();
    _springPosition = newSpringPosition;

    notifyListeners();
  }

  Offset _previousVelocity = Offset.zero;

  void startSpring() {
    _springSimX = SpringSimulation(
      _springDescription,
      springPosition.dx,
      anchorPosition.dx,
      _previousVelocity.dx,
    );

    _springSimY = SpringSimulation(
      _springDescription,
      springPosition.dy,
      anchorPosition.dy,
      _previousVelocity.dy,
    );

    _ticker ??= _tickerProvider.createTicker(_onTick);

    _ticker!.start();
  }

  void _onTick(Duration elapsedTime) {
    final elapsedTimeFraction = elapsedTime.inMilliseconds / 1000.0;

    _springPosition = Offset(
      _springSimX.x(elapsedTimeFraction),
      _springSimY.x(elapsedTimeFraction),
    );

    _previousVelocity = Offset(
      _springSimX.dx(elapsedTimeFraction),
      _springSimY.dx(elapsedTimeFraction),
    );

    if (_springSimX.isDone(elapsedTimeFraction) &&
        _springSimY.isDone(elapsedTimeFraction)) {
      endSpring();
    }

    notifyListeners();
  }

  void endSpring() {
    _ticker?.stop();
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
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(anchorPosition, springPosition, paint);
  }

  @override
  bool shouldRepaint(WebPracticePainter oldDelegate) {
    return springPosition != oldDelegate.springPosition ||
        anchorPosition != oldDelegate.anchorPosition;
  }
}
