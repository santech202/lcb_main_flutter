import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liceucubrio/course.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'util/data.dart';
import 'package:liceucubrio/util/ui_components.dart';
import 'package:audioplayers/audioplayers.dart';

class Lesson extends StatefulWidget {
//  final String title;
  Map<String, dynamic> lesson;
  int lessonNr;
  int lessonViews = 0;
  int nrOfLessons;
  Data app_data = Data();
  AudioPlayer audioPlayer = AudioPlayer();

  Lesson(this.lesson, this.lessonNr, this.nrOfLessons);
  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  List<Widget> lessonList = new List<Widget>();
  int partsNo = 0;

  int countLessonViews() {
    return widget.lessonViews++;
  }

  /// count parts of lesson
  int _countParts() {
    int counter = 1;
    for (int j = 0; j < widget.lesson.length; j++) {
      if (widget.lesson.containsKey(
          'l' + widget.lessonNr.toString() + '_p' + j.toString())) {
        counter++;
      }
//      print(counter);
    }
    return counter;
  }

  /// build the page
  List<Widget> _buildLessonsWithContent() {
    _countParts();

    /// here we do the remainingViews decrement
    HomePageState homePage = HomePageState();
    homePage.decrementViewsNr();
    homePage.incrementTotalViewsEverNr();

    /// ACTUAL BODY (LESSON CONTENT)
    for (int i = 1; i < _countParts(); i++) {
      lessonList.add(
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Text(
            this
                .widget
                .lesson['l' + widget.lessonNr.toString() + '_p' + i.toString()],
            textAlign: TextAlign.justify,
          ),
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.orange[300],
          ),
        ),
      );
      // daca cumva gaseste poza (row cu img in lista, adauga poza la lessonList)
      if (widget.lesson[
              'l' + widget.lessonNr.toString() + '_' + 'img' + i.toString()] ==
          null) {
        // do nothing (row with img is empty)
      } else {
        // image found -> add it to the list
        lessonList.add(Image(
          image: AssetImage(widget.lesson[
              'l' + widget.lessonNr.toString() + '_' + 'img' + i.toString()]),
        ));
//        print('am gasit imagine');
//        print(i);
      }
    }

    /// footer code for instagram
    _launchURL() async {
      const url = "https://www.instagram.com/bac_cu_brio";
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
    }

    /// build footer element
    lessonList.add(GestureDetector(
      child: Column(
        children: <Widget>[
          Text(
            widget.app_data.app_strings['insta_label'],
            textAlign: TextAlign.center,
          ),
          Image(
            image: AssetImage('assets/img/instagram-min.png'),
            height: 50,
          ),
          Text(widget.app_data.app_strings['instagram_username']),
        ],
      ),
      onTap: () {
        _launchURL();
      },
    ));

    return lessonList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: lessonsAppBar(
          context,
          this.widget.lesson['l' + widget.lessonNr.toString() + '_title'],
          HomePage()),
      body: ListView(
        children: _buildLessonsWithContent(),
      ),
    );
  }
}
