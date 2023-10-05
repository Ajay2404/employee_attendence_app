import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  Future<Database> getDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Employee(id INTEGER PRIMARY KEY autoincrement, firstname TEXT, lastname text, number text)");
      await db.execute(
          "Create table MonthData(id integer primary key autoincrement, report text, userid integer, DATE text)");
    });
    return database;
  }

  Future<void> employeeInsertData(
      String number, String firstname, String lastname, Database db) async {
    String sql =
        "INSERT INTO Employee (number,firstname,lastname) VALUES ('$number','$firstname','$lastname')";
    int result = await db.rawInsert(sql);
    print(result);
  }

  Future<List<Map>> getEmployeeData(Database db) async {
    String sql = "SELECT * FROM Employee";
    List<Map> result = await db.rawQuery(sql);
    return result;
  }

  Future<bool> InsertMonthlyReport(
      int userid, String date, String report, Database db) async {
    String checkdate = "select * from MonthData where date = '$date'";
    String checkd = "select * from MonthData where userid = '$userid'";
    List<Map> selecteddata = await db.rawQuery(checkdate);
    List<Map> selecteddata1 = await db.rawQuery(checkd);
    if (selecteddata.length == 0 || selecteddata1.length == 0) {
      String imr =
          "Insert Into MonthData(userid,DATE,report) values('$userid','$date','$report')";
      int wer = await db.rawInsert(imr);
      print("adgjhdsvhj$wer");
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map>> viewMonthlyData(Database db) async {
    String vmd = "SELECT * FROM MonthData";
    List<Map> vmdr = await db.rawQuery(vmd);
    return vmdr;
  }
}
