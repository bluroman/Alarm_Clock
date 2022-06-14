import 'package:flutter/material.dart';

class GradientAnimation extends StatefulWidget {
  const GradientAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<GradientAnimation> createState() => _GradientAnimationState();
}

class _GradientAnimationState extends State<GradientAnimation>
    with TickerProviderStateMixin {
  late Animation gradientAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    gradientAnimation = Tween(begin: 0.0, end: 0.5).animate(animationController)
      ..addListener(() {
        if (gradientAnimation.value == 0.0) {
          animationController.forward();
        } else if (gradientAnimation.value == 0.5) {
          animationController.reverse();
        }
        setState(() {});
      })
      ..addStatusListener((status) {});
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
            colors: const [
              Colors.blue,
              Colors.red,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [gradientAnimation.value, 1]),
      ),
    );
  }
}
