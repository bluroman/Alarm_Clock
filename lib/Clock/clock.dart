// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

late double seconds = DateTime.now().second * 6.0;
late double minutes = DateTime.now().minute * 6.0;
late double hours = DateTime.now().hour * 30.0 + DateTime.now().minute * 0.5;

class _ClockState extends State<Clock> with TickerProviderStateMixin {
  late Animation second_Hand_Animation;
  late AnimationController second_Hand_AnimationController;

  late Animation minutes_Hand_Animation;
  late AnimationController minutes_Hand_AnimationController;

  late Animation hours_Hand_Animation;
  late AnimationController hours_Hand_AnimationController;

  bool clock_showed = false;
  bool hands_showed = false;
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        setState(() {
          clock_showed = true;
        });
      },
    );
    Future.delayed(
      const Duration(milliseconds: 1100),
      () {
        setState(() {
          hands_showed = true;
        });
      },
    );
    var time = DateTime.now();
    var seound_Tween =
        Tween(begin: time.second * 6.0, end: (time.second + 1) * 6.0);
    var minute_Tween =
        Tween(begin: time.minute * 6.0, end: (time.minute + 1) * 6.0);

    hours_Hand_AnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // var hcurved = CurvedAnimation(parent: hours_Hand_AnimationController, curve: Curves.easeInOutBack);
    minutes_Hand_AnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    var minute_curved = CurvedAnimation(
        parent: minutes_Hand_AnimationController, curve: Curves.easeInOutBack);

    minutes_Hand_Animation = minute_Tween.animate(minute_curved)
      ..addListener(() {
        setState(() {
          minutes = minutes_Hand_Animation.value;
        });
      })
      ..addStatusListener((status) {});
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time.second != DateTime.now().second) {
        if (time.minute != DateTime.now().minute) {
          setState(() {
            minute_Tween =
                Tween(begin: time.minute * 6.0, end: (time.minute + 1) * 6.0);
            minutes_Hand_AnimationController = AnimationController(
                vsync: this, duration: const Duration(seconds: 1));
            minute_curved = CurvedAnimation(
                parent: minutes_Hand_AnimationController,
                curve: Curves.easeInOutBack);

            minutes_Hand_Animation = minute_Tween.animate(minute_curved)
              ..addListener(() {
                setState(() {
                  minutes = minutes_Hand_Animation.value;
                });
              })
              ..addStatusListener((status) {});
            minutes_Hand_AnimationController.forward();
          });
          setState(() {
            hours_Hand_AnimationController = AnimationController(
                vsync: this, duration: const Duration(seconds: 1));
            var hour_Tween = Tween(
                begin: time.hour * 30.0 + time.minute * 0.5,
                end: time.hour * 30.0 + (time.minute + 1) * 0.5);
            var hour_curved = CurvedAnimation(
                parent: hours_Hand_AnimationController,
                curve: Curves.easeInOutBack);
            hours_Hand_Animation = hour_Tween.animate(hour_curved)
              ..addListener(() {
                setState(() {
                  hours = hours_Hand_Animation.value;
                });
              })
              ..addStatusListener((status) {});
            hours_Hand_AnimationController.forward();
          });
        }
        if (time.hour != DateTime.now().hour) {}
        setState(() {
          time = DateTime.now();

          seound_Tween =
              Tween(begin: time.second * 6.0, end: (time.second + 1) * 6.0);
        });
      }

      second_Hand_AnimationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));

      var second_curved = CurvedAnimation(
          parent: second_Hand_AnimationController, curve: Curves.easeInOutBack);
      second_Hand_Animation = seound_Tween.animate(second_curved)
        ..addListener(() {
          setState(() {
            seconds = second_Hand_Animation.value;
          });
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {}
        });

      second_Hand_AnimationController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    hours_Hand_AnimationController.dispose();
    minutes_Hand_AnimationController.dispose();
    second_Hand_AnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutBack,
            scale: clock_showed ? 1 : 0,
            child: SizedBox(
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: ClockPainter(),
              ),
            ),
          ),
          AnimatedScale(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutBack,
            scale: hands_showed ? 1 : 0,
            child: SizedBox(
              width: 300,
              height: 300,
              child: Transform.rotate(
                angle: -pi / 2,
                child: CustomPaint(
                  painter: HandPainter(),
                ),
              ),
            ),
          ),
          AnimatedScale(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutBack,
            scale: clock_showed ? 1 : 0,
            child: SizedBox(
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: CenterCireclePainter(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CenterCireclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    Paint centerCirclePainter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.1, centerCirclePainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ClockPainter extends CustomPainter {
  var time = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    Paint backgroundPainter = Paint()
      ..color = const Color(0xFF443737)
      ..style = PaintingStyle.fill;

    Paint borderPainter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    canvas.drawCircle(center, radius, backgroundPainter);

    canvas.drawCircle(center, radius, borderPainter);

    var dash_starting_point = radius - 20;
    var big_dash_end = radius - 35;
    var small_dash_end = radius - 30;

    Paint big_dash_Painter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    Paint small_dash_Painter = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    for (int i = 0; i < 360; i += 6) {
      var x1 = centerX + dash_starting_point * cos(i * pi / 180);
      var y1 = centerX + dash_starting_point * sin(i * pi / 180);

      var x2 = centerX + small_dash_end * cos(i * pi / 180);
      var y2 = centerX + small_dash_end * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), small_dash_Painter);
    }

    for (int i = 0; i < 360; i += 30) {
      var x1 = centerX + dash_starting_point * cos(i * pi / 180);
      var y1 = centerX + dash_starting_point * sin(i * pi / 180);

      var x2 = centerX + big_dash_end * cos(i * pi / 180);
      var y2 = centerX + big_dash_end * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), big_dash_Painter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    var c = Offset(centerX, centerY);

    Paint minutesPainter = Paint()
      ..shader = const LinearGradient(
        colors: [
          Colors.orange,
          Colors.white,
        ],
      ).createShader(Rect.fromCenter(center: c, width: 90, height: 20))
      ..strokeWidth = 9.5
      ..strokeCap = StrokeCap.round;

    Paint secondPainter = Paint()
      ..shader = const LinearGradient(
        colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ],
      ).createShader(Rect.fromCenter(center: c, width: 90, height: 20))
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    Paint hoursPainter = Paint()
      ..shader = const LinearGradient(
        colors: [
          Colors.pink,
          Colors.white,
        ],
      ).createShader(Rect.fromCenter(center: c, width: 90, height: 20))
      ..strokeWidth = 10.5
      ..strokeCap = StrokeCap.round;

    var hourX = centerX + 60 * cos(hours * pi / 180);
    var hourY = centerX + 60 * sin(hours * pi / 180);
    canvas.drawLine(c, Offset(hourX, hourY), hoursPainter);

    var minX = centerX + 75 * cos(minutes * pi / 180);
    var minY = centerX + 75 * sin(minutes * pi / 180);
    canvas.drawLine(c, Offset(minX, minY), minutesPainter);

    var secX = centerX + 85 * cos(seconds * pi / 180);
    var secY = centerX + 85 * sin(seconds * pi / 180);
    canvas.drawLine(c, Offset(secX, secY), secondPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
