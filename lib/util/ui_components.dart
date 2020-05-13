import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liceucubrio/main.dart';
import 'package:liceucubrio/pages/premium.dart';
import 'package:liceucubrio/pages/stats1.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'constants.dart';

Color appBarColor = Colors.blue;
Widget basicAppBar(BuildContext context, String title, String route) {
  return AppBar(
    flexibleSpace: Container(
      color: appBarColor,
    ),
    title: Text(title),
    elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
    leading: new IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushNamed(context, "$route");
        }),
  );
}

Widget courseAppBar(BuildContext context, String title, [dynamic back_obj]) {
  return AppBar(
    flexibleSpace: Container(
      color: appBarColor,
    ),
    title: Text(title),
    elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
    leading: new IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () async {
          Navigator.pushNamed(context, "/home");
        }),
  );
}

Widget lessonsAppBar(BuildContext context, String title, [dynamic back_obj]) {
  return AppBar(
    flexibleSpace: Container(
//      decoration: new BoxDecoration(
//          gradient: new LinearGradient(
//        colors: [
//          Colors.orange,
//          Colors.white,
//        ],
//        begin: const FractionalOffset(0.0, 0.0),
//        end: const FractionalOffset(2, 0.0),
//        stops: [0.0, 1.0],
//        tileMode: TileMode.clamp,
//      )),
      color: appBarColor,
    ),
    title: Text(title),
    elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
//    leading: new IconButton(
//        icon: Icon(Icons.arrow_back),
//        onPressed: () {
//          Navigator.of(context).push(new MaterialPageRoute(
//              builder: (BuildContext context) => back_obj));
//        }),
  );
}

Widget avatarGlow(double height) {
  return AvatarGlow(
    glowColor: Colors.orange,
    endRadius: height * 1.5,
    duration: Duration(milliseconds: 2000),
    repeat: true,
    showTwoGlows: true,
    repeatPauseDuration: Duration(milliseconds: 100),
    child: Material(
      elevation: 8.0,
      shape: CircleBorder(),
      child: CircleAvatar(
        backgroundColor: Colors.grey[100],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            'assets/img/logo.png',
            fit: BoxFit.fill,
          ),
        ),
        radius: height,
      ),
    ),
  );
}

/// used in statistics page
Widget statsButton(BuildContext context, Object clasa, String btnText) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: RaisedButton.icon(
      color: Colors.lightBlue,
      label: Expanded(
        flex: 10,
        child: Text(
          btnText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      icon: Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.lock,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) => clasa));
      },
    ),
  );
}

Widget richTextWithIcon(BuildContext context, IconData icon, String text) {
  return RichText(
    text: TextSpan(
      style: Theme.of(context).textTheme.bodyText1,
      children: [
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              icon,
              size: statsIconsSize,
              color: Colors.green,
            ),
          ),
        ),
        TextSpan(text: text),
      ],
    ),
  );
}

Widget loadingGif() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: FadeInImage.assetNetwork(
          placeholder: cupertinoActivityIndicator,
          image:
              "https://raw.githubusercontent.com/Codelessly/FlutterLoadingGIFs/master/packages/cupertino_activity_indicator_square_small.gif",
          placeholderScale: 5,
        ),
      ),
    ],
  );
}

//Widget noMoreViewsAlert(BuildContext context) {
//  Alert(
//          context: context,
//          title: "Nu mai ai vizionari!",
//          desc:
//              "Poti viziona o reclama pentru 2 vizionari!\n Majoritatea elevilor isi incarca numarul de vizionari ca sa scape de griji.")
//      .show();
//}

Widget noMoreViewsAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Nu mai ai vizualizari",
    desc:
        "1 reclama scurta = 2 vizualizari!\n Majoritatea elevilor isi incarca numarul de vizualizari ca sa scape de griji.",
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "Incarca acum",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}

Widget viewsAddedAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: 'Felicitari!',
    desc: 'Vizualizarile tale au fost actualizate!',
    buttons: [
      DialogButton(
        child: Text(
          "Inchide",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
    ],
  ).show();
}
