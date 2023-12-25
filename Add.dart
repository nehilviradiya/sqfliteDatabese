import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'contect.dart';
import 'dbhelper.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

TextEditingController mnumber = TextEditingController();
final _random = Random();
final _formKey = GlobalKey<FormState>();
TextEditingController controller = TextEditingController();

class _AddState extends State<Add> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabase();
  }

  void getDatabase() {
    Dbhelper().Getdatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
  }


  TextEditingController title = TextEditingController();
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {

                  if (_formKey.currentState!.validate()) {
                    _submit();
                    String titledata = title.text;
                    String current = time.toString();
                    String data = controller.text;

                    try {
                      setState(() {
                        Dbhelper().insertdata(db!, titledata,current,data);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const Contect(),
                                type: PageTransitionType.fade));
                      });
                    } on Exception catch (e) {
                      // TODO
                      debugPrint('---------------------->>$e');
                    }
                  }
                },
                child: const Icon(Icons.save, color: Colors.black)),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(

                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),
                controller: title,
                decoration: InputDecoration(hintText: 'Title',
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,),
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
                onChanged: (value) {

                },
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
              // Form(
              //   key: _formKey,
              //   child:
              // ).marginOnly(left: 15),
            ],
          )),
    );
  }


}
