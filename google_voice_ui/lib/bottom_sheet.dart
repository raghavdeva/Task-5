import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBarDialog(),
      ),
    ),
  ));
}

class AnimatedBarDialog extends StatefulWidget {
  const AnimatedBarDialog({Key? key}) : super(key: key);

  @override
  State<AnimatedBarDialog> createState() => _AnimatedBarDialogState();
}

class _AnimatedBarDialogState extends State<AnimatedBarDialog> {
  final int barCount = 4;
  final double maxBarWidth = 300.0;
  List<double> barWidths = [];
  Timer? barAnimationTimer;

  Color _getBarColor(int position) {
    switch (position) {
      case 0:
        return const Color(0xff3F82F1);
      case 1:
        return const Color(0xffEB4033);
      case 2:
        return const Color(0xffEEBB27);
      case 3:
        return const Color(0xff4CAC54);
      default:
        return Colors.blueGrey;
    }
  }

  @override
  void initState() {
    super.initState();
    barWidths = List.filled(barCount, maxBarWidth / barCount);
    _startAnimationLoop();
  }

  @override
  void dispose() {
    barAnimationTimer?.cancel();
    super.dispose();
  }

  void _generateRandomWidths() {
    Random randomizer = Random();
    List<double> randomValues = List.generate(barCount, (_) => randomizer.nextDouble());
    double totalRandomSum = randomValues.reduce((a, b) => a + b);

    setState(() {
      barWidths = randomValues.map((value) => (value / totalRandomSum) * maxBarWidth).toList();
    });
  }

  void _startAnimationLoop() {
    barAnimationTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _generateRandomWidths();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            height: 5,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 30),
          const Image(
            image: AssetImage('assets/icons-removebg-preview.png'),
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 20),
          const Text(
            'Speak to Google',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(barCount, (position) {
                return AnimatedContainer(
                  decoration: BoxDecoration(
                    color: _getBarColor(position),
                    boxShadow: [
                      BoxShadow(
                        color: _getBarColor(position).withOpacity(0.8),
                        blurRadius: 15.0,
                        spreadRadius: 6.0,
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 200),
                  width: barWidths[position],
                  height: 10,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
