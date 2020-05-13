import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liceucubrio/main.dart';
import 'package:liceucubrio/quiz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'util/data.dart';
import 'lesson.dart';
import 'package:liceucubrio/util/ui_components.dart';
import 'package:http/http.dart' as http;

class Course extends StatefulWidget {
  // declare the util/Data class

  // course
  Map<String, dynamic> course;
  // lessons of the course
  Map<String, dynamic> lessons;
  Course(this.course, this.lessons);

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {

  final String url = "https://smobx1.github.io/lcb_quiz.json";
  Data app_data = Data();
  List<RaisedButton> buttonsList = new List<RaisedButton>();
  List data;

  List checkboxValues = [];

  bool checkBoxValue1 = false;
  bool checkBoxValue2 = false;
  bool checkBoxValue3 = false;
  bool checkBoxValue4 = false;


  int totalNoOfLessons = 0;
  SharedPreferences prefs;

  String savingName = '';

  @override
  void initState() {

    super.initState();

    getcheckName();

  }

 Future<String> getPrefs() async{

    prefs = await SharedPreferences.getInstance();

    for (int i = 1; i < widget.course.length; i ++){
      bool value = prefs.getBool(savingName + i.toString());

      if(value != null){

        setState(() {
          if(i == 1){
            checkBoxValue1 = value;
          }else if(i == 2){
            checkBoxValue2 = value;
          }else if( i == 3){
            checkBoxValue3 = value;
          }else if( i == 4){
            checkBoxValue4 = value;
          }
        });

      }else{
        print('empty');
      }
    }


    return 'Ok';

  }


  void getcheckName(){
    String str = widget.course['name'];

    List arr = str.split(' - ');
    savingName = arr[1];
    print(savingName);

    int a = widget.course.length;
    print(a);

  }


//  List<dynamic> _buildButtonsWithNames(){
//
//
//    for (int i = 1; i < widget.course.length; i++) {
//      if (widget.course['lesson$i'] != null) {
//
//        print('Index ' + i.toString());
//
//        print(savingName + i.toString());
//
//        Future.delayed(const Duration(milliseconds: 1000), () {
//          getboolValue(i).then((value){
//            if(value != null){
//
//              print('Hi: ' + value.toString());
//
//              setState(() {
//                checkBoxValue = value;
//              });
//
//            }else{
//              print('Error: ' + value.toString());
//            }
//
//          });
//        });
//
//
//        buttonsList.add(
//          RaisedButton(
//            color: Colors.white,
//            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//            onPressed: () async {
//
//              Navigator.of(context).push(new MaterialPageRoute(
//                  builder: (BuildContext context) =>
//                      Lesson(widget.lessons, i, i)));
//
//            },
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: [
//                Expanded(
//                  flex: 1,
//                  child: Text(
//                    widget.course['lesson$i' + '_time'],
//                  ),
//                ),
//                Expanded(
//                  flex: 5,
//                  child: Container(
//                    width: 200,
//                    child: Text(
//                      widget.course['lesson$i'],
//                      overflow: TextOverflow.ellipsis,
//                      maxLines: 5,
//                      style: TextStyle(color: Colors.black),
//                    ),
//                  ),
//                ),
//                StatefulBuilder(
//                    builder: (BuildContext context, StateSetter setState) {
//                  return Container(
//                    height: 20,
//                    child: Transform.scale(
//                      scale: 1.3,
//                      child: Checkbox(
//                        value: checkBoxValue,
//                        onChanged: (bool value) {
//                          print(value);
//                          setState(() {
//                            checkBoxValue = value;
//
//                            prefs.setBool(savingName + i.toString(), checkBoxValue);
//
//                            print(savingName + i.toString());
//
//                          });
//                        },
//                      ),
//                    ),
//                  );
//                })
//              ],
//            ),
//          ),
//        );
//      } else {
//
//      }
//    }
//    return buttonsList;
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: courseAppBar(context, widget.course['name'], HomePage()),


      body: FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot){

          if(snapshot.hasData){

            return ListView.builder(
              itemCount: widget.course.length,
              itemBuilder: (BuildContext context, int i){

                int realIndex = i + 1;

                if(widget.course['lesson$realIndex'] != null){

                  return RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {

                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Lesson(widget.lessons, realIndex, realIndex)));

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            widget.course['lesson$realIndex' + '_time'],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: 200,
                            child: Text(
                              widget.course['lesson$realIndex'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          child: Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: realIndex == 1
                                  ? checkBoxValue1
                                  : realIndex == 2
                                    ? checkBoxValue2
                                      : realIndex == 3
                                        ? checkBoxValue3
                                          : checkBoxValue4,
                              onChanged: (bool value) {
                                print(value);
                                setState(() {

                                  if(realIndex == 1){
                                    checkBoxValue1 = value;
                                    prefs.setBool(savingName + realIndex.toString(), checkBoxValue1);
                                  }else if(realIndex == 2){
                                    checkBoxValue2 = value;
                                    prefs.setBool(savingName + realIndex.toString(), checkBoxValue2);
                                  }else if(realIndex == 3){
                                    checkBoxValue3 = value;
                                    prefs.setBool(savingName + realIndex.toString(), checkBoxValue3);
                                  }else if(realIndex == 4){
                                    checkBoxValue4 = value;
                                    prefs.setBool(savingName + realIndex.toString(), checkBoxValue4);
                                  }


                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );

                }else{

                }
              },
            );
          }
          return CircularProgressIndicator();
        },
      )
    );
  }

}
