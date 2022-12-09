import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map_training/common/theme.dart';

double deg2rad(double deg) => deg * pi / 180;

class ChargingProgressIndicator extends StatefulWidget {
  const ChargingProgressIndicator({Key? key}) : super(key: key);

  @override
  State<ChargingProgressIndicator> createState() =>
      _ChargingProgressIndicatorState();
}

class _ChargingProgressIndicatorState extends State<ChargingProgressIndicator> {
  double progress = 0;
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        progress = progress >= 360 ? 0.0 : progress + 3;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ChargingProgressIndicatorPainter(
        percentage: 0.24,
        progress: progress,
      ),
      child: const SizedBox(
        height: 200,
        width: 200,
      ),
    );
  }
}

class _ChargingProgressIndicatorPainter extends CustomPainter {
  final double percentage;
  final double progress;

  _ChargingProgressIndicatorPainter({
    required this.percentage,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);

    _drawCircles(canvas, center, radius);
    _drawIcon(canvas, Offset(size.height / 2 - 15, size.width / 2 - 82));
    _drawText(
      canvas,
      center,
      radius,
      text: '${(percentage * 100).floor()}%',
      textStyle: const TextStyle(
        color: greyBlue,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      textOffset: -45,
    );
    _drawText(
      canvas,
      center,
      radius,
      text: '6.74 kWh',
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      textOffset: -8,
    );
    _drawText(
      canvas,
      center,
      radius,
      text: 'Delivered',
      textStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
      textOffset: 20,
    );
    _drawArc(canvas, center, radius + 10);

    final paint = Paint()
      ..color = greyBlue
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius+10),
      deg2rad(progress),
      0.01,
      false,
      paint,
    );
  }

  void _drawArc(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..shader = SweepGradient(
        colors: const [
          greyWhite,
          greyBlue,
        ],
        transform: GradientRotation(deg2rad(progress)),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(
      center,
      radius,
      paint,
    );
  }

  void _drawIcon(Canvas canvas, Offset offset) {
    const icon = Icons.bolt_rounded;
    TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 25,
          color: greyBlue,
          fontFamily: icon.fontFamily,
        ),
      )
      ..layout()
      ..paint(canvas, offset);
  }

  void _drawText(
    Canvas canvas,
    Offset center,
    double radius, {
    required String text,
    required TextStyle textStyle,
    required double textOffset,
  }) {
    final span = TextSpan(
      style: textStyle,
      text: text,
    );
    final tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
        canvas,
        Offset(
          radius - tp.width / 2,
          radius - tp.height / 2 + textOffset,
        ));
  }

  void _drawCircles(Canvas canvas, Offset center, double radius) {
    final oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius + 5));
    final shadowPaint = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(oval, shadowPaint);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      center,
      radius - 10,
      Paint()
        ..color = greyWhite
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
