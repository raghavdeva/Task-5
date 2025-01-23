import 'package:bottom_navigation/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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
  RiveAssets selectedItems = bottomNavItems.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: SafeArea(child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: const BorderRadius.all(Radius.circular(28)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [...List.generate(
            bottomNavItems.length,
                (index) => GestureDetector(
              onTap: () {
                bottomNavItems[index].input!.change(true);
                if(bottomNavItems[index] != selectedItems){
                  setState(() {
                    selectedItems = bottomNavItems[index];
                  });
                }
                Future.delayed(Duration(seconds: 1),(){
                  bottomNavItems[index].input!.change(false);
                });

              },
              child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Opacity(
                      opacity: bottomNavItems[index] == selectedItems ? 1: 0.5,
                      child: RiveAnimation.asset(
                        bottomNavItems.first.src,
                        artboard: bottomNavItems[index].artboard,
                        onInit: (artboard) {
                          StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName:
                              bottomNavItems[index].stateMachineName);

                          bottomNavItems[index].input =
                          controller.findSMI("active") as SMIBool;
                        },
                      ),
                    ),
                  ),
            ),
          )],
        ),
      )),
    );
  }
}
class RiveAssets{
  late final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAssets(
      this.src,
      {
        required this.artboard,
        required this.stateMachineName,
        required this.title,
        this.input,
      });

  set setInput(SMIBool? status){
    input = status;
  }
}
List<RiveAssets> bottomNavItems = [
  RiveAssets("assets/little_icons.riv", artboard: "HOME", stateMachineName: "HOME_interactivity", title: "Home"),
  RiveAssets("assets/little_icons.riv", artboard: "SEARCH", stateMachineName: "SEARCH_Interactivity", title: "Dashboard"),
  RiveAssets("assets/little_icons.riv", artboard: "BELL", stateMachineName: "BELL_Interactivity", title: "Notification"),
  RiveAssets("assets/little_icons.riv", artboard: "SETTINGS", stateMachineName: "SETTINGS_Interactivity", title: "Settings"),
];

