import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liceucubrio/pages/stats1.dart';
import 'package:liceucubrio/pages/stats2.dart';
import 'package:liceucubrio/pages/stats3.dart';
import 'package:liceucubrio/util/constants.dart';
import 'package:liceucubrio/util/ui_components.dart';
import 'util/data.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:http/http.dart' as http;

class Statistics extends StatefulWidget {
  Data app_data = Data();

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  String videoURL = "https://www.youtube.com/watch?v=hAB5sC7uA8A";
  final String url = "https://smobx1.github.io/lcb_json_test.json";
  List data;

//  YoutubePlayerController _controller;

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
      data = convertDataToJson['history'];
      print(data);
    });
    return "Success";
  }

  @override
  void initState() {
//    _controller = YoutubePlayerController(
//        initialVideoId: YoutubePlayer.convertUrlToId(videoURL));
    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: courseAppBar(context, 'Ce pica la Bac?'),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        ' Beneficii',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      richTextWithIcon(context, Icons.check_circle_outline,
                          ' Aflii ce e mai probabil sa pice'),
                      richTextWithIcon(context, Icons.check_circle_outline,
                          ' Programa simplificata'),
                      richTextWithIcon(context, Icons.check_circle_outline,
                          ' Intelegi mai bine ce se cere'),
                      richTextWithIcon(context, Icons.check_circle_outline,
                          ' Poti elimina capitole/lectii'),
                      richTextWithIcon(context, Icons.check_circle_outline,
                          ' Aflii ce e mai probabil sa pice'),
                      richTextWithIcon(context, Icons.check_circle_outline,
                          ' Vezi ce a picat in ultimii ani'),
                      richTextWithIcon(context, Icons.check_circle_outline,
                          ' Actualizari pana in dimineata examenului'),
                    ],
                  ),
                ),
              ),
              Expanded(
                //TODO: find a suitable image
                flex: 1,
                child: avatarGlow(50.0),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        ' Cum functioneaza?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      richTextWithIcon(context, Icons.calendar_today,
                          ' Analizand toate examenele trecute (ambele sesiuni)'),
                      richTextWithIcon(context, Icons.language,
                          ' Analizand contextul actual'),
                      richTextWithIcon(context, Icons.history,
                          ' Studiand cum/ce am gresit in anii trecuti'),
                      richTextWithIcon(
                          context, Icons.lightbulb_outline, ' Altele'),
                    ],
                  ),
                ),
              ),
              Expanded(
                //TODO: find a suitable image
                flex: 1,
                child: avatarGlow(50.0),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          statsButton(context, Stats1(), 'Stats 1'),
          statsButton(context, Stats2(), 'Stats 2'),
          statsButton(context, Stats3(), 'Stats 3'),
          SizedBox(
            height: 10,
          ),
          //TODO fa asta sa se ia tot din JSON
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Rezultate anii trecuti (Bac cu Brio)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '* pot fi verificate pe internet',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          data == null
              ? loadingGif()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              data[index]["an"],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data[index]["statistica"],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Varianta " + data[index]["varianta"],
                          ),
                        ),
                      ],
                    );
                  },
                ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Detalii',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.app_data.premiumToggleText,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
