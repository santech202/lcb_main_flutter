import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liceucubrio/util/ui_components.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorsProfile extends StatefulWidget {
  int id;
  List data;
  TutorsProfile(this.data, this.id);
  @override
  _TutorsProfileState createState() => _TutorsProfileState();
}

class _TutorsProfileState extends State<TutorsProfile> {
  // check if user is male or female
  _profileImage() {
    String gender = '';
    if (widget.data[widget.id]['gender'] == 'male') {
      gender = 'male';
    } else {
      gender = 'female';
    }
    return AssetImage('assets/img-tutors/$gender.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar(
          context,
          widget.data[widget.id]['first_name'] +
              ' ' +
              widget.data[widget.id]['last_name'],
          '/tutors'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image(
                  image: _profileImage(),
                  height: 150,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(widget.data[widget.id]['first_name'] +
                    ' ' +
                    widget.data[widget.id]['last_name']),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(widget.data[widget.id]['description']),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Table(
              border: TableBorder.all(color: Colors.black26, width: 1),
              children: [
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        'Preda',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        widget.data[widget.id]['teaches'],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        'Experienta',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        widget.data[widget.id]['experience'].toString() +
                            ' ani',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        'Oras',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        widget.data[widget.id]['city'],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        'Locatie',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        widget.data[widget.id]['location'],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        'Disponibil si online',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        widget.data[widget.id]['online'],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        'Pret',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        widget.data[widget.id]['price'],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: FlatButton(
                      onPressed: () =>
                          launch("tel://" + widget.data[widget.id]['phone']),
                      color: Colors.orange,
                      child: new Text(
                        widget.data[widget.id]['phone'],
                        style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
