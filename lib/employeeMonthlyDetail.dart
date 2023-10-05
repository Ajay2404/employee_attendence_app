import 'package:employee_attendence_app/databaseHelper.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class EmployeeMonthlyData extends StatefulWidget {
  @override
  State<EmployeeMonthlyData> createState() => _EmployeeMonthlyDataState();

  const EmployeeMonthlyData({Key? key}) : super(key: key);
}

class _EmployeeMonthlyDataState extends State<EmployeeMonthlyData> {
  List<Map> ap = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewMonthlyData();
  }

  void viewMonthlyData() {
    DataBaseHelper().viewMonthlyData(SplashScreen.db!).then((value) {
      setState(() {
        for (int i = 0; i < value.length; i++) {
          if (SplashScreen.prefs!.getInt('userid1') == value[i]['userid']) {
            ap.add(value[i]);
            print('aksdjfhsadjfsdajh${ap}');
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: ap.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:
                    ap[index]['report'] == 'Absent' ? Colors.red : Colors.green,
              ),
              child: ListTile(
                title: Text("${ap[index]['report']}"),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
        ),
      ),
    );
  }
}
