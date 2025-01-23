import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: BottomSheetDialog(),
      ),
    ),
  ));
}

class BottomSheetDialog extends StatefulWidget {
  const BottomSheetDialog({Key? key}) : super(key: key);

  @override
  State<BottomSheetDialog> createState() => _BottomSheetDialogState();
}

class _BottomSheetDialogState extends State<BottomSheetDialog> {
  final int Count = 4; // Number of bars
  final double total_widht = 300.0; // Total width of all bars combined
  List<double> box_widht = []; // Individual widths of each bar
  Timer? animationTimer;

  Color _getBoxColor(int index) {
    switch (index) {
      case 0:
        return Color(0xff3F82F1);
      case 1:
        return Color(0xffEB4033);
      case 2:
        return Color(0xffEEBB27);
      case 3:
        return Color(0xff4CAC54);
      default:
        return Colors.blueGrey;
    }
  }


  @override
  void initState() {
    super.initState();
    box_widht = List.filled(Count, total_widht / Count);
    startPeriodicAnimation();
  }

  @override
  void dispose() {
    animationTimer?.cancel();
    super.dispose();
  }

  void length() {
    Random random = Random();
    List<double> randomWidths = List.generate(Count, (index) => random.nextDouble());
    double totalRandomValue = randomWidths.reduce((a, b) => a + b);

    setState(() {
      box_widht = randomWidths.map((value) => (value / totalRandomValue) * total_widht).toList();
    });
  }

  /// Starts periodic animation for the bars
  void startPeriodicAnimation() {
    animationTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      length();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 280,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        color:  Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          // Top handle bar
          Container(
            height: 5,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 30),
          // Placeholder image
          const Image(
            image: AssetImage('assets/icons-removebg-preview.png'),
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 20),
          // Placeholder text
          Text(
            'Speak to Google',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          // Animated bars at the bottom
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(Count, (index) {
                return AnimatedContainer(
                  decoration: BoxDecoration(
                    color: _getBoxColor(index), // Bar color
                    boxShadow: [
                      BoxShadow(
                        color: _getBoxColor(index).withOpacity(0.8),
                        blurRadius: 15.0,
                        spreadRadius: 6.0,
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 200), // Animation duration
                  width: box_widht[index],
                  height: 10,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),// Fixed height for all bars
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}


