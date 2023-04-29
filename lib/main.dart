import 'dart:async';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: CountdownTimerList(),
    );
  }
}


class TimerItem {
  int timeInSeconds = 0;
  bool isRunning = false;
  Timer? timer;
  bool isResume = false;
  TimerItem(this.timeInSeconds);
}

class CountdownTimerList extends StatefulWidget {
  @override
  _CountdownTimerListState createState() => _CountdownTimerListState();
}

class _CountdownTimerListState extends State<CountdownTimerList> {
  final List<TimerItem> timers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Timers'),
      ),
      body: ListView.builder(
        itemCount: timers.length,
        itemBuilder: (BuildContext context, int index) {
          TimerItem timerx = timers[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 90,
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                               border: Border.all(color: Colors.black)
                                  ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter seconds',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  timerx.timeInSeconds = int.tryParse(value) ?? 0;
                                  
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 50,
                            decoration: BoxDecoration(
                               border: Border.all(color: Colors.black)
                                  ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _formatDuration(Duration(seconds: timerx.timeInSeconds)),textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        height: 50,
                        width: 80,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black)
                          )
                        )
                      ),
                          onPressed: () {
                            setState(() {
                              timerx.isRunning = !timerx.isRunning;
                              if (timerx.isRunning) {
                                timerx.timer = Timer.periodic(Duration(seconds: 1), (timer) {
                                  setState(() {
                                    if (timerx.timeInSeconds > 0) {
                                      timerx.timeInSeconds--;
                                    } else {
                                      timerx.isRunning = false;
                                      timerx.isResume = false;
                                      timerx.timer?.cancel();
                                    }
                                  });
                                });
                              } else {
                                timerx.timer?.cancel();
                                timerx.isResume = true;
                              }
                            });
                          },
                          child: Text(timerx.isRunning ? 'Pause' :
                          timerx.isResume ? 'Resume':"Start",style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            timers.add(TimerItem(0));
          });
        },
        child: Icon(Icons.timer),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  
}