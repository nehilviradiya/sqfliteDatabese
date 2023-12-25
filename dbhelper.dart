import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Dbhelper {

  Future<Database> Getdatabase() async {

    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'create table abc (id integer primary key autoincrement,title text,currenttime text,data text)');
    });
    return database;
  }

  void insertdata(Database db1, String titledata,String currenttime,String data) async {
    String insert =
        "insert into abc (title,currenttime,data) values('$titledata','$currenttime','$data')";
    try {
      await db1.rawQuery(insert);

    } on Exception catch (e) {
      // TODO
      debugPrint('----------------------->>>>>>>>$e');
      Fluttertoast.showToast(
          msg: "You give already note number so please give another number",
          backgroundColor: Colors.black,
          textColor: Colors.white,
          timeInSecForIosWeb: 5);
    }
  }

  Future<List<Map>> viewdata(Database database) async {
    String view = "select * from abc";
    List<Map> list = await database.rawQuery(view);
    return list;
  }

  void updatedata(Database db, String updname, int updatanumber, int id,) {
    String update = "UPDATE abc SET number = ?,mname = ? WHERE id= $id";
      db.rawUpdate(update,[updatanumber,updname]);
  }

  void deletedata(Database db, int id) {
    String delete = "delete from abc where id = $id";
    db.rawDelete(delete);
  }
}
