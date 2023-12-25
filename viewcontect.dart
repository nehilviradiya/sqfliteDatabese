import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'contect.dart';
import 'dbhelper.dart';

class Viewc extends StatefulWidget {
  Map aa;

  Viewc(this.aa, {super.key});

  @override
  State<Viewc> createState() => _ViewcState();
}

class _ViewcState extends State<Viewc> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController showTitle =
        TextEditingController(text: '${widget.aa['title']}');
    TextEditingController controller =
        TextEditingController(text: '${widget.aa['data']}');

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Notes'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {
            int id = widget.aa['id'];
            setState(() {
              Dbhelper().deletedata(db!, id);
            });
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const Contect(),
                    type: PageTransitionType.fade));
          }, icon: Icon(
            Icons.delete_outline,
            color: Colors.red,
          ).marginOnly(right: 15))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    controller: showTitle,
                    decoration: InputDecoration(
                      hintText: 'Titel',
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ).marginAll(15),
                  TextFormField(
                    controller: controller,
                    maxLines: null,
                    minLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Enter the text',
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ).marginOnly(left: 15),
                ],
              )),
        ),
      ),
    );
  }
}
