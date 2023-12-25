import 'dart:math';
import 'package:easy_grade/notes/viewcontect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqlite_api.dart';
import '../pages/home_page/home_page.dart';
import 'Add.dart';
import 'dbhelper.dart';

class Contect extends StatefulWidget {
  const Contect({super.key});

  @override
  State<Contect> createState() => _ContectState();
}

Database? db;

class StickyColors {
  static final List colors = [
    const Color(0xffFD99FF).withOpacity(0.5),
    const Color(0xffFF9E9E),
    const Color(0xff91F48F),
    const Color(0xffFFF599),
    const Color(0xff9EFFFF),
    const Color(0xffB69CFF),
  ];
}

final _random = Random();

class _ContectState extends State<Contect> {
  List aa = [];

  @override
  initState() {
    Getalldata();
    super.initState();
  }

  Getalldata() {

    Dbhelper().Getdatabase().then((value) {
      setState(() {
        db = value;
      });
      debugPrint('------------------------->>>>>>>>>>$value');
      Dbhelper().viewdata(db!).then((value1) {
        setState(() {
          aa = value1;
        });
        debugPrint('------------------------>>>>>>>>>>$aa');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff246AFD),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const Add(), type: PageTransitionType.fade));
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
                  child: Text(
                    'Notes',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Spacer()
              ],
            ),
            Row(
              children: [
                SizedBox
                  (
                  height: height / 1,
                  width: width / 1,
                  child: aa.isNotEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: aa.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Viewc(aa[index]),
                                  type: PageTransitionType.fade));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: StickyColors.colors[index],
                          ),
                          child: ListTile(
                            subtitle: Text('${aa[index]['currenttime']}'),
                            title: Text('${aa[index]['title']}',

                                style: const TextStyle(fontSize: 18)),
                          ),
                        ).marginOnly(
                            left: 20, top: 10, right: 20, bottom: 10),
                      );
                    },
                  )
                      : Container(
                      color: Colors.white54,
                      height: 100,
                      child: const Center(
                        child: Text(
                          'No Notes',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
