import 'dart:math';

import 'package:animation/AlarmClock/Screens/clock_screen.dart';
import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);

    Paint clockPainer = Paint()
      ..color = const Color(0xFF1f2535)
      ..strokeWidth = 38
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    var radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, clockPainer);

    Paint clockPainer2 = Paint()
      ..color =
          (TimeOfDay.now().period.name == 'am' ? Colors.amber : Colors.blue)
      ..strokeWidth = 38
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2 * pi * (TimeOfDay.now().hour / 24),
      -2 * pi * (animation.value / 24),
      false,
      clockPainer2,
    );

    var dashStartingPoint = radius - 30;
    var bigDashEnd = radius - 45;
    var smallDashEnd = radius - 40;

    Paint bigDashPainter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    Paint smallDashPainter = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    for (int i = 0; i < 360; i += 15) {
      var x1 = size.width / 2 + dashStartingPoint * cos(i * pi / 180);
      var y1 = size.width / 2 + dashStartingPoint * sin(i * pi / 180);

      var x2 = size.width / 2 + smallDashEnd * cos(i * pi / 180);
      var y2 = size.width / 2 + smallDashEnd * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), smallDashPainter);
    }

    for (int i = 0; i < 360; i += 30) {
      var x1 = size.width / 2 + dashStartingPoint * cos(i * pi / 180);
      var y1 = size.width / 2 + dashStartingPoint * sin(i * pi / 180);

      var x2 = size.width / 2 + bigDashEnd * cos(i * pi / 180);
      var y2 = size.width / 2 + bigDashEnd * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), bigDashPainter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
