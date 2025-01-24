import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    home: Task7(),
  ));
}

class Task7 extends StatefulWidget {
  const Task7({super.key});

  @override
  State<Task7> createState() => _Task7State();
}

class _Task7State extends State<Task7> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor:  Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Animated Tab Effect',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: TabBar(
                  controller: _tabController,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelPadding: EdgeInsets.only(left: 20, right: 20),
                  labelColor: Colors.black,
                  dividerColor: Colors.black,
                  unselectedLabelColor:Colors.grey[500],
                  // indicator: CircleTabIndicator(
                  //   color: isDarkMode ? Colors.white : Colors.grey,
                  //   radius: 3,
                  // ),
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(text: "Home", icon: Icon(Icons.home)),
                    Tab(text: "Earth",icon: Icon(Iconsax.global_bold),),
                    Tab(icon: Icon(Icons.settings)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Center(
                      child: Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text("This is the home page", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),),
                          ),
                        ),
                      )
                    ),
                    Center(
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),

                            child: Center(
                              child: Text("This is the Earth page", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),),
                            ),
                          ),
                        )
                    ),
                    Center(
                        child: Expanded(
                          child: Container(
                            
                            decoration: BoxDecoration(
                              color: Colors.yellow[300],
                            ),
                            child: Center(
                              child: Text("This is the Settings page", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500 , color: Colors.black),),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}