import 'package:animation/AlarmClock/Screens/clock_screen.dart';
import 'package:animation/Clock/clock.dart';
import 'package:animation/DragAndDrop/drag_and_drop.dart';
import 'package:animation/GradientAnimation/gradient_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AlarmClock(),
      debugShowCheckedModeBanner: false,
    );
  }
}
