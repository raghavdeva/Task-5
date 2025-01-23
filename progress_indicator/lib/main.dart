import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _activeStep = 0; // The current active step

  // Function to go to the next step
  void _nextStep() {
    setState(() {
      if (_activeStep < 3) {
        _activeStep++; // Move to the next step if it's less than the total steps
      }
    });
  }
  void _prevStep() {
    setState(() {
      if (_activeStep > 0) {
        _activeStep--; // Move to the next step if it's less than the total steps
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Indicator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EasyStepper(
            activeStep: _activeStep, // The current active step
            lineStyle: LineStyle(lineLength: 50, lineThickness: 3, defaultLineColor: Colors.blue, unreachedLineType: LineType.dashed, unreachedLineColor: Colors.grey),
            finishedStepBackgroundColor: Colors.green,
            activeStepBorderColor: Colors.red,
            activeStepBackgroundColor: Colors.indigoAccent,
            stepBorderRadius: 10,
            borderThickness: 5,
            stepShape: StepShape.rRectangle,
            unreachedStepBackgroundColor: Colors.grey,
            unreachedStepIconColor: Colors.grey,
            unreachedStepBorderColor: Colors.grey,
            unreachedStepTextColor: Colors.grey,
            showLoadingAnimation: false,
            steps: [
              EasyStep(
                customStep: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Opacity(
                  opacity: _activeStep >= 0 ? 1 : 0.3,
                  child: Image.asset('assets/images/shopping.png'),
                ),
              ),
                customTitle: const Text(
                  'Shopping',
                  textAlign: TextAlign.center,
                ),
              ),
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Opacity(
                    opacity: _activeStep >= 1 ? 1 : 0.3,
                    child: Image.asset('assets/images/home.png'),
                  ),
                ),
                customTitle: const Text(
                  'Address',
                  textAlign: TextAlign.center,
                ),
              ),
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Opacity(
                    opacity: _activeStep >= 2 ? 1 : 0.3,
                    child: Image.asset('assets/images/payment.png'),
                  ),
                ),
                customTitle: const Text(
                  'Payment',
                  textAlign: TextAlign.center,
                ),
              ),
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Opacity(
                    opacity: _activeStep >= 3 ? 1 : 0.3,
                    child: Image.asset('assets/images/check.png',),
                  ),
                ),
                customTitle: const Text(
                  'Check Out',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ElevatedButton(
                onPressed: _prevStep,
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: _nextStep,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
