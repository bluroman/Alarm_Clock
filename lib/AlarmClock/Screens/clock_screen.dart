import 'dart:async';
import 'dart:math';
import 'package:animation/AlarmClock/Components/clock_painter.dart';
import 'package:animation/AlarmClock/Components/digital_and_alarm.dart';
import 'package:animation/AlarmClock/Widgets/hour_picker.dart';
import 'package:flutter/material.dart';

late Animation animation;
double angle = 0.1;

class AlarmClock extends StatefulWidget {
  const AlarmClock({Key? key}) : super(key: key);

  @override
  State<AlarmClock> createState() => _AlarmClockState();
}

class _AlarmClockState extends State<AlarmClock> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController opacityController;
  late AnimationController scaleController;

  late Animation scaleAnimation;
  late Animation opacityAnimation;

  double hour = 0.1;
  TimeOfDay timeOfDay = TimeOfDay.now();
  TimeOfDay? alarm;

  @override
  void initState() {
    initAnimation(0.1);

    opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    opacityAnimation = Tween(begin: 1.0, end: 0.1).animate(
        CurvedAnimation(parent: opacityController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: opacityController, curve: Curves.easeInOutExpo))
      ..addListener(() {
        setState(() {});
      });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeOfDay.minute != TimeOfDay.now().minute) {
        setState(() {
          timeOfDay = TimeOfDay.now();
        });
      }
    });

    super.initState();
  }

  Future<bool> initAnimation(double value) async {
    print(value);

    // if (value.toInt() == timeOfDay.hour) {
    //   setState(() {
    //     hour = 0.1;
    //   });
    //   await animationController.reverse();
    //   await initAnimation(0.1);
    //   return false;
    // }
    setState(() {
      hour = 0.1;
    });
    if (value != 0.1) {
      await animationController.reverse();
    }
    double v;
    if (timeOfDay.hour == 0 && value == 12) {
      v = -(value + 12);
    } else if (timeOfDay.hour == 0 && value == 24) {
      v = -12;
    } else if (timeOfDay.hour == 12 && value == 12) {
      v = -12;
    } else if (timeOfDay.hour == 12 && value == 24) {
      v = -value;
    } else if (timeOfDay.hour >= value) {
      v = timeOfDay.hour - (value + 24);
    } else {
      v = (timeOfDay.hour - value);
    }
    print(v);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    animation = Tween(begin: 0.1, end: v.toDouble()).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutExpo))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1f2a3e),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                opacityController.forward();
                scaleController.forward();
              },
              child: Opacity(
                opacity: opacityAnimation.value,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Transform.rotate(
                    angle: -pi / 2,
                    child: CustomPaint(
                        painter: Painter(),
                        child: DigitalClockAndAlarm(
                          alarm: alarm,
                        )),
                  ),
                ),
              ),
            ),
          ),
          if (alarm?.hour != timeOfDay.hour)
            Center(
              child: Transform.rotate(
                angle: 2 * pi * (timeOfDay.hour / 24),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  alignment: Alignment.topCenter,
                  height: 338,
                  width: 338,
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: Transform.rotate(
                        angle: -2 * pi * (timeOfDay.hour / 24),
                        child: Image.asset(
                          timeOfDay.period.name == 'pm'
                              ? 'asset/moon (2).png'
                              : 'asset/sun (2).png',
                          height: 24,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
          if (hour != 0.1)
            Center(
              child: Transform.rotate(
                alignment: AlignmentDirectional.center,
                angle: 2 * pi * ((hour) / 24),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  alignment: Alignment.topCenter,
                  height: 338,
                  width: 338,
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: Transform.rotate(
                        angle: -2 * pi * ((hour) / 24),
                        child: Image.asset(
                          'asset/notification (2).png',
                          height: 24,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
          IgnorePointer(
            ignoring: scaleAnimation.value == 1 ? false : true,
            child: GestureDetector(
              onTap: () {
                scaleController.reverse();
                opacityController.reverse();
              },
              child: Container(
                color: Colors.black.withOpacity(0.0),
                alignment: Alignment.center,
              ),
            ),
          ),
          Transform.scale(
            scale: scaleAnimation.value,
            child: HourPicker(
              callback: (h, m, t) async {
                h += 1;
                if (t == 1) {
                  h += 12;
                }
                scaleController.reverse();
                opacityController.reverse();

                bool l = await initAnimation(h.toDouble());
                print(l);
                alarm = TimeOfDay(
                    hour: t == 0
                        ? h == 12
                            ? 0
                            : h
                        : h == 24
                            ? 12
                            : h,
                    minute: m);
                if (l) {
                  await animationController.forward();
                  if (timeOfDay.hour == 0 && h == 12) {
                    hour = h + 12;
                  } else if (timeOfDay.hour == 0 && h == 24) {
                    hour = -12;
                  } else if (timeOfDay.hour == 12 && h == 12) {
                    hour = 0;
                  } else if (timeOfDay.hour == 12 && h == 24) {
                    hour = 12;
                  } else {
                    hour = h.toDouble();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
