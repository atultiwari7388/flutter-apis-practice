import 'dart:async';
import 'package:apisflutter/View/Covid/world_state.covid.view.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  //create animation controller
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WorldStatsView()),
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              child: const SizedBox(
                height: 200.0,
                width: 200.0,
                child: Center(
                  child: Image(
                    image: AssetImage("assets/virus.png"),
                  ),
                ),
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Covid 19",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
