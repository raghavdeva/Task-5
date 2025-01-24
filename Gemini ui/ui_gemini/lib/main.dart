import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late bool isvisible;
  late Animation<double> _animation;

  final starShapes = [
    CircleShapeBorder(),
    StarShapeBorder(
      corners: 6,
      inset: 11.6953125.toPercentLength,
      cornerRadius: (231.2508167053851 * 0.1667).toPXLength,
      insetRadius: 0.toPXLength,
      cornerStyle: CornerStyle.rounded,
      insetStyle: CornerStyle.rounded,
    ),
    StarShapeBorder(
      corners: 6,
      inset: 12.6.toPercentLength,
      cornerRadius: (60 * 0.1667).toPXLength,
      insetRadius: (160 * 0.1667).toPXLength,
      cornerStyle: CornerStyle.rounded,
      insetStyle: CornerStyle.rounded,
    ),
    PolygonShapeBorder(
      sides: 6,
      cornerRadius: 60.toPercentLength,
      cornerStyle: CornerStyle.rounded,

    ),

    StarShapeBorder(
      corners: 6,
      inset: 30.44002474993097.toPercentLength,
      cornerRadius: (86.54205560062454 * 0.1667).toPXLength,
      insetRadius: (55.23216904049404 * 0.1667).toPXLength,
      cornerStyle: CornerStyle.rounded,
      insetStyle: CornerStyle.rounded,
    ),
    StarShapeBorder(
      corners: 6,
      inset: 30.toPercentLength,
      cornerRadius: (206.3 * 0.1667).toPXLength,
      insetRadius: (5.7 * 0.1667).toPXLength,
      cornerStyle: CornerStyle.rounded,
      insetStyle: CornerStyle.rounded,
    ),
  ];

  late AnimationController _controller;
  late Animation _progressAnimation;
  late MorphableShapeBorderTween _shapeTween;
  int _currentIndex = 0;

  void _setNextTween() {
    final beginShape = starShapes[_currentIndex];
    final endShape = starShapes[(_currentIndex + 1) % starShapes.length];
    _shapeTween = MorphableShapeBorderTween(begin: beginShape, end: endShape);
  }

  Timer? _timer;
  ValueNotifier<double> listenable = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    isvisible = false;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    Animation<double> curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);

    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(curve);
    ;

    _setNextTween();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % starShapes.length;
          _setNextTween();
        });
        _controller.forward(from: 0);
      }
    });

    _controller.forward();

    listenable.value = Random().nextDouble() * 10;

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      listenable.value += 0.01;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Gemini UI',
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 400),
                          child: ElevatedButton(onPressed: (){
                            setState(() {
                              isvisible = true;
                            });
                          }, child: Text('Ask Gemini')),
                        ),
                        Opacity(
                          opacity: isvisible ? 1 : 0,
                          child: ValueListenableBuilder(
                            valueListenable: listenable,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return AnimatedRotation(
                                turns: value,
                                duration: const Duration(milliseconds: 1000),
                                child: ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (bounds) =>
                                        LinearGradient(colors: [
                                          Colors.blueAccent,
                                          Colors.purpleAccent,

                                        ],
                                        stops: [_animation.value, _animation.value + 1.8 ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                          tileMode: TileMode.mirror,
                                        ).createShader(
                                          Rect.fromLTWH(
                                              5, 5, bounds.width, bounds.height),
                                        ),
                                    child:
                                        AnimatedBuilder(
                                            animation: _progressAnimation,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              double t = _progressAnimation.value;
                                              return Center(
                                                  child: DecoratedShadowedShape(
                                                decoration: BoxDecoration(
                                                    color: Colors.amberAccent),
                                                shape: _shapeTween.lerp(t),
                                                child: Container(
                                                  width: 150,
                                                  height: 150,
                                                ),
                                              ));
                                            })),
                              );
                            },
                          ),
                        ),

                        Opacity(
                          opacity: isvisible? 1 :  0.0,
                          child: Container(
                            height: 50,
                            width: 50,

                            child: Image(

                              image: AssetImage('assets/gemini.png' ,),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Opacity(
                            opacity: isvisible ? 0 : 1,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Image(
                              image: AssetImage('assets/gemini-modified.png'),
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
              ))
            ],
          )),
    );
  }
}
