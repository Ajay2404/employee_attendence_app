import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../add_new_employee_screen/add_new_employee_screen.dart';
import '../databaseHelper.dart';
import '../employeeMonthlyDetail.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? report;
  String formattedDate = DateFormat("d-M-y").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    viewData();
  }

  viewData() {
    DataBaseHelper().getEmployeeData(SplashScreen.db!).then((value) {
      setState(() {
        AddNewEmployee.employeelist = value;
      });
    });
  }

  insertMonthlyData() async {
    int userid = await SplashScreen.prefs!.getInt("userid1") ?? 0;
    String report = await SplashScreen.prefs!.getString("report") ?? "";
    DataBaseHelper()
        .InsertMonthlyReport(userid, formattedDate, report, SplashScreen.db!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formattedDate),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: AddNewEmployee.employeelist.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(bottom: 10),
              height: 70,
              decoration: BoxDecoration(
                  color: Color(0xffff4c4b),
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(5),
              child: ListTile(
                onTap: () {
                  setState(() {
                    SplashScreen.prefs!.setInt(
                        "userid1", AddNewEmployee.employeelist[index]['id']);
                  });
                  print(SplashScreen.prefs!.getInt("userid1") ?? 0);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EmployeeMonthlyData();
                    },
                  ));
                },
                title: Center(
                  child: Row(
                    children: [
                      Text(
                        "${AddNewEmployee.employeelist[index]['firstname']}",
                      ),
                      Text(
                        " ${AddNewEmployee.employeelist[index]['lastname']}",
                      ),
                    ],
                  ),
                ),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ToggleSwitch(
                    minWidth: 30.0,
                    activeBgColors: const [
                      [Colors.blue],
                      [Colors.blue],
                    ],
                    inactiveBgColor: Colors.grey,
                    initialLabelIndex: 1,
                    totalSwitches: 2,
                    labels: const ['A', 'P'],
                    radiusStyle: true,
                    onToggle: (ind) {
                      if (ind == 0) {
                        report = "Absent";
                        SplashScreen.prefs!.setString("report", "$report");
                        print("$ind");
                      } else {
                        report = "Present";
                        SplashScreen.prefs!.setString("report", "$report");
                        print("$ind");
                      }
                      SplashScreen.prefs!.setInt(
                          "userid1", AddNewEmployee.employeelist[index]["id"]);
                      insertMonthlyData();
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddNewEmployee();
            },
          ));
        },
        tooltip: 'Add New Employee',
        elevation: 2.0,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
