import 'package:flutter/material.dart';
import '../services.dart/lists.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    void addToHabitList(String habitName, String habitDescription) {
      habitList.add([false, habitName, habitDescription, Icon(Icons.abc)]);
    }

    void addHabit(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController habitNameController = TextEditingController();
            TextEditingController habitDescriptionController =
                TextEditingController();
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
                            habitDescriptionController.text);
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"))
              ],
            );
          });
    }
    Color getColor(double value) {
          if (value < 0.3)
          {
              return Colors.red;
          } 
          else if (value > 0.3 && value <0.6)
          {
              return Colors.yellow;
          }
          else
          {
              return Colors.green;
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                      Row(children: [
                        Icon(Icons.battery_charging_full_outlined),
                        Text("${((counter / habitList.length) * 100).clamp(0, 100).toInt()}%",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16))
                      ],),
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
                        valueColor: AlwaysStoppedAnimation<Color>(getColor(counter/habitList.length)),
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
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              )
              :  SizedBox(
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
                              counter = habitList.where((item) => item[0]).length;
                            });
                          },
                          child: ListTile(
                            title: Text(habitList[index][1]),
                            subtitle: Text(habitList[index][2]),
                            trailing: habitList[index][3],
                            leading: Checkbox(
                              value: habitList[index][0],
                              onChanged: ((value) {
                                setState(() {
                                  if (value == false) {
                                    counter -= 1;
                                    print(counter.toString());
                                    habitList[index][0] = value;
                                  } else
                                    counter += 1;
                                  print(counter.toString());
                                  habitList[index][0] = value;
                                });
                              }),
                            ),
                          ));
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
