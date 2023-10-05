import 'package:employee_attendence_app/databaseHelper.dart';
import 'package:employee_attendence_app/home_page_screen/home_page_screen.dart';
import 'package:employee_attendence_app/main.dart';
import 'package:flutter/material.dart';

class AddNewEmployee extends StatefulWidget {


  const AddNewEmployee({Key? key}) : super(key: key);
  static List<Map> employeelist = [];

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Add Employee Details"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: firstname,
              decoration: InputDecoration(
                fillColor: const Color(0xff000000),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "First Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: lastname,
              decoration: InputDecoration(
                fillColor: const Color(0xff000000),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Last Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: number,
              decoration: InputDecoration(
                fillColor: const Color(0xff000000),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Enter Your Number",
              ),
            ),
          ),
          InkWell(
            onTap: () {
              DataBaseHelper().employeeInsertData(
                  number.text, firstname.text, lastname.text, SplashScreen.db!);
              setState(() {});

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              width: 200,
              height: 70,
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
