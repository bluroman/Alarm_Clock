// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';

class DigitalClockAndAlarm extends StatelessWidget {
  DigitalClockAndAlarm({Key? key, this.alarm}) : super(key: key);

  TimeOfDay? alarm;
  @override
  Widget build(BuildContext context) {
    TimeOfDay timeOfDay = TimeOfDay.now();
    return Transform.rotate(
        angle: pi / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timeOfDay.format(context),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              alarm == null ? '--:--' : alarm!.format(context),
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: alarm == null ? 3 : 0.5),
            ),
          ],
        ));
  }
}
