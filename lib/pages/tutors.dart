import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liceucubrio/pages/tutorsProfile.dart';
import 'package:liceucubrio/util/ui_components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Tutors extends StatefulWidget {
  @override
  _TutorsState createState() => _TutorsState();
}

class _TutorsState extends State<Tutors> {
  final String url = "https://smobx1.github.io/lcb_teachers.json";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['teachersData'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar(context, 'Tutors', '/home'),
      endDrawer: Drawer(),
      body: data == null
          ? loadingGif()
          : ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                //TODO: create filters based on city / subject
                _profileImage() {
                  String gender = '';
                  if (data[index]['gender'] == 'male') {
                    gender = 'male';
                  } else {
                    gender = 'female';
                  }
                  return AssetImage('assets/img-tutors/$gender.png');
                }

                return Card(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                          height: 150,
                          color: Colors.grey[200],
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      image: _profileImage(),
                                      height: 100,
                                      alignment: Alignment.bottomRight,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      data[index]['first_name'] +
                                          " " +
                                          data[index]['last_name'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Vezi Profil',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      color: Colors.orangeAccent,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    // pasez numarul profesorilui la profilul profesorului
                                                    new TutorsProfile(
                                                        data, index)));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          height: 150,
                          color: Colors.grey[200],
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      data[index]['teaches'],
                                      style: TextStyle(fontSize: 9),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Experienta: ' +
                                          data[index]['experience'].toString() +
                                          ' ani',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Varsta: ' +
                                          data[index]['age'].toString() +
                                          ' ani',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => launch(
                                            "tel://" + data[index]['phone']),
                                        color: Colors.orangeAccent,
                                        child: new Text(
                                          data[index]['phone'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue[900]),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          height: 150,
                          color: Colors.grey[200],
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Oras: ' + data[index]['city'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Locatie: ' + data[index]['location'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 8),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Disponibil online: ' +
                                          data[index]['online'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Pret: ' + data[index]['price'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
