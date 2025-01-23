import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
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

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Animated Tab Effect", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SegmentedTabControl(

                barDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFAB9A5FF)
                ),
                tabTextColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
                tabs: [
                SegmentTab(label: "Home", color: Colors.lightBlue,selectedTextColor: Colors.black, textColor: Colors.white, ),
                SegmentTab(label: "View Earth", color: Colors.lightGreen,selectedTextColor: Colors.black, textColor: Colors.white),
                SegmentTab(label: "Settings", color: Color(0xFFCCCC1A), textColor: Colors.white, selectedTextColor: Colors.black)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: TabBarView(children: [
                Container(color: Colors.lightBlue,),
                Container(color: Colors.lightGreen),
                Container(color: Color(0xFFCCCC1A))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
