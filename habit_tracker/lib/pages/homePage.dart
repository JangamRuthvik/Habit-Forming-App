import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../services.dart/lists.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import './timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  int _hoursSelected = 0;
  int _minutesSelected = 0;
  int tsx = 0;
  int csx = 0;
  bool check = false;
  TimeOfDay _timeOfDay = TimeOfDay(hour: 11, minute: 27);
  @override
  Widget build(BuildContext context) {
    void addToHabitList(String habitName, String habitDescription, int a) {
      habitList.add([false, habitName, habitDescription, Icon(Icons.abc), a]);
    }

    //   void _showTimepicker() {
    //   showTimePicker(context: context, initialTime: TimeOfDay.now())
    //       .then((value) {
    //     setState(() {
    //       _timeOfDay = value!;
    //     });
    //   });
    // }
    void addHabit(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController habitNameController = TextEditingController();
            TextEditingController habitDescriptionController =
                TextEditingController();
            TextEditingController remainderController = TextEditingController();
            return AlertDialog(
              title: Text("Add a Habit"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Habit Name'),
                    controller: habitNameController,
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Habit Descriiption'),
                    controller: habitDescriptionController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('choose the time to focus')),
                      FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Select Time"),
                                  content: Container(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Hours',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('minutes',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        TimePickerSpinner(
                                          is24HourMode: true,
                                          time: DateTime(0, 0),
                                          isForce2Digits: true,
                                          spacing: 60,
                                          itemHeight: 40,
                                          itemWidth: 60,
                                          alignment: Alignment.center,
                                          normalTextStyle: TextStyle(
                                              fontSize: 20, color: Colors.grey),
                                          highlightedTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                          onTimeChange: (time) {
                                            setState(() {
                                              _hoursSelected = time.hour;
                                              _minutesSelected = time.minute;
                                              tsx = (_hoursSelected * 60 * 60) +
                                                  (_minutesSelected * 60);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        child: Icon(Icons.timer_rounded),
                        mini: true,
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                        surfaceTintColor:
                            MaterialStateProperty.all(Colors.purpleAccent)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                        surfaceTintColor:
                            MaterialStateProperty.all(Colors.purpleAccent)),
                    onPressed: () {
                      setState(() {
                        addToHabitList(habitNameController.text,
                            habitDescriptionController.text, tsx);
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"))
              ],
            );
          });
    }

    Color getColor(double value) {
      if (value < 0.3) {
        return Colors.red;
      } else if (value > 0.3 && value < 0.6) {
        return Colors.yellow;
      } else {
        return Colors.green;
      }
    }

    bool check = false;
    void createalarm(String S) {
      if (check == true) {
        int hour = 0;
        int minutes = 0;
        hour = _timeOfDay.hour;
        minutes = _timeOfDay.minute;
        FlutterAlarmClock.createAlarm(hour, minutes, title: S);
      }
    }

    void _showTimepicker(String s) {
      showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((value) {
        setState(() {
          _timeOfDay = value!;
          check = true;
          createalarm(s);
        });
      });
    }

    void updateHabitList(int index, int totalSeconds) {
      habitList[index][4] -= totalSeconds;
    }

    void sameupdate(int index) {
      Future.delayed(Duration.zero, () {
        setState(() {
          habitList[index][0] = true;
          counter = habitList.where((habit) => habit[0] == true).length;
        });
      });
    }

    Text getCompletionStatus(int index) {
      if (habitList[index][4] == 0) {
        sameupdate(index);
        return Text('completed');
      } else if (habitList[index][4] > 60) {
        return Text('${((habitList[index][4]) / 60).round()} minutes left');
      } else if (habitList[index][4] <= 60 && habitList[index][4] > 0) {
        return Text('${habitList[index][4]} seconds left');
      } else {
        return Text('');
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() {
          addHabit(context);
        }),
        tooltip: 'Add a Habit',
        label: Text('Add Habit'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.deepPurple)),
        elevation: 5,
        highlightElevation: 10,
        isExtended: true,
        heroTag: 'addHabitButton',
      ),
      backgroundColor: Colors.black,
      body: ListView(padding: EdgeInsets.zero, children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(children: [
              Image.asset('assets/tokyo.png'),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 220, 0, 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    Text(
                      "HELLO FOLKS!",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "You have ${habitList.length - counter} habits left for today",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ]),
                ),
              )
            ]),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Keep Going!",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      Row(
                        children: [
                          Icon(Icons.battery_charging_full_outlined),
                          Text(
                              "${((counter / habitList.length) * 100).clamp(0, 100).toInt()}%",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: 25,
                      color: Colors.black,
                      backgroundColor: Colors.black12,
                      value: (counter / habitList.length),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          getColor(counter / habitList.length)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(),
                ),
                habitList.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'You have no habits yet!',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 400,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: habitList.length,
                          itemBuilder: (context, int index) {
                            return Dismissible(
                              key: Key(habitList[index].toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: Colors.red,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              onDismissed: (direction) {
                                setState(() {
                                  habitList.removeAt(index);
                                  counter =
                                      habitList.where((item) => item[0]).length;
                                });
                              },
                              child: ListTile(
                                title: Text(habitList[index][1]),
                                // subtitle: Text(habitList[index][2]),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(habitList[index][2]),
                                    getCompletionStatus(index),
                                  ],
                                ),

                                leading: Checkbox(
                                  value: habitList[index][0],
                                  onChanged: ((value) {
                                    setState(() {
                                      if (value == false) {
                                        // counter -= 1;
                                        // print(counter.toString());
                                        // habitList[index][0] = value;
                                      } else{
                                        // counter += 1;
                                      // print(counter.toString());
                                      // habitList[index][0] = false;
                                      }
                                    });
                                  }),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _showTimepicker(habitList[index][1]);
                                      },
                                      child: Icon(
                                        Icons.alarm,
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    GestureDetector(
                                      onTap: () async {
                                        final List<dynamic> result =
                                            await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyApp()),
                                        );
                                        final bool isCompleted = result[0];
                                        final int totalSeconds = result[1];
                                        print('isCompleted :${isCompleted}');
                                        print('totalSeconds :${totalSeconds}');
                                        setState(() {
                                          check = isCompleted;
                                          if (check == true) {
                                            updateHabitList(
                                                index, totalSeconds);
                                          }
                                        });
                                      },
                                      child: Icon(Icons.hourglass_empty),
                                    ),
                                    PopupMenuButton(
                                      itemBuilder: (BuildContext context) => [
                                        PopupMenuItem(
                                          child: Text('Rename'),
                                          value: 'rename',
                                        ),
                                        PopupMenuItem(
                                          child: Text('Delete'),
                                          value: 'delete',
                                        ),
                                      ],
                                      onSelected: (value) {
                                        if (value == 'rename') {
                                          // Show dialog to rename the habit
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              String newName =
                                                  habitList[index][1];
                                              return AlertDialog(
                                                title: Text('Rename Habit'),
                                                content: TextField(
                                                  autofocus: true,
                                                  decoration: InputDecoration(
                                                    labelText: 'New Name',
                                                    hintText:
                                                        'Enter new habit name',
                                                  ),
                                                  onChanged: (value) {
                                                    newName = value;
                                                  },
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        habitList[index][1] =
                                                            newName;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Rename'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else if (value == 'delete') {
                                          // Delete the habit
                                          setState(() {
                                            habitList.removeAt(index);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
