import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SimplePage extends StatefulWidget {
  Map<String, String> pageData;
  SimplePage(this.pageData);
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<SimplePage> {
  int _countParts() {
    int counter = 0;
    for (int j = 0; j < widget.pageData.length; j++) {
      if (widget.pageData.containsKey('p' + j.toString())) {
        counter++;
      }
    }
    return counter;
  }

  List<Widget> _buildSimplePage() {
    List<dynamic> elementsList = new List<Widget>();
    for (int i = 1; i <= _countParts(); i++) {
      elementsList.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Text(widget.pageData['p' + i.toString()],
            textAlign: TextAlign.justify),
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange[300],
        ),
      ));
    }

    // footer code
    _launchURL() async {
      const url = 'https://www.instagram.com/bac_cu_brio';
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
    }

    // footer element
    elementsList.add(GestureDetector(
      child: Column(
        children: <Widget>[
          Text(
            widget.pageData['insta_label'],
            textAlign: TextAlign.center,
          ),
          Image(
            image: AssetImage('assets/img/instagram-min.png'),
            height: 50,
          ),
          Text('@' + widget.pageData['instagram_username']),
        ],
      ),
      onTap: () {
        _launchURL();
      },
    ));

    return elementsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
          )),
        ),
        title: Text(widget.pageData['title']),
      ),
      body: ListView(
        children: _buildSimplePage(),
      ),
    );
  }
}
