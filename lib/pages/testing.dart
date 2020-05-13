import 'dart:convert';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:liceucubrio/main.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import '../util/ui_components.dart';
import 'package:liceucubrio/util/ui_components.dart';
import 'package:http/http.dart' as http;

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final String url = "https://smobx1.github.io/lcb_json_test.json";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
    print('Testing Page called');
  }

  Future<String> getJsonData() async {
    var response = await http.get(
      // Encode the URL
      Uri.encodeFull(url),
      // Only accept JSON response
      headers: {"Accept": "application/json"},
    );
//    print(response.body);

    setState(() {
      //TODO: print something to tell the user if the internet is not working
      if (response.statusCode == 200) {
        print('200');
      } else {
        print('nu e 200');
      }
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['stats1'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: basicAppBar(context, 'Testing', '/home'),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          int probs = data[index]['probability'];
          //TODO: Add blurr overlay and make it toggle hide/show when not-paid/paid (IAP)
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.all(15.0),
              child: new LinearPercentIndicator(
                animation: true,
                animationDuration: 2000,
                lineHeight: 30.0,
                leading: new Text("Epic"),
                trailing: new Text("Liric"),
                percent: data[index]['epic'] / 100,
                center: Text(data[index]['epic'].toString() + "%"),
                linearStrokeCap: LinearStrokeCap.butt,
                progressColor: Colors.orange,
              ),
            );
          }
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: new Container(
                            child: new Text(data[index]['name']),
                            padding: const EdgeInsets.all(10),
                          ),
                        ),
                        new CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 5.0,
                          percent: data[index]['probability'] / 100,
                          center: new Text(
                              data[index]['probability'].toString() + "%"),
                          progressColor: Colors.green,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
