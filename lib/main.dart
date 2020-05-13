import 'dart:convert';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:liceucubrio/pages/termsAndConds.dart';
import 'package:liceucubrio/statistics.dart';
import 'package:liceucubrio/stopWatch.dart';
import 'package:liceucubrio/testingAds.dart';
import 'package:liceucubrio/util/ui_components.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'audioTesting.dart';
import 'just_audio.dart';
import 'util/data.dart';
import 'course.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'simplePage.dart';
import 'pages/premium.dart';
import 'pages/tutors.dart';
import 'pages/testing.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(LiceuApp());
}


class LiceuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == "/home")
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => HomePage());
        if (routeSettings.name == "/stats")
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => Statistics());
        if (routeSettings.name == "/tutors")
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => Tutors());
        if (routeSettings.name == "/terms")
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => TermsAndConds());
        if (routeSettings.name == "/testingAudio")
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => ExampleApp());
        if (routeSettings.name == "/testingAudio2")
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => MyApp());
        if (routeSettings.name == "/testingads")
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => TestingAds());
        if (routeSettings.name == "/stopwatch")
          return PageRouteBuilder(
              pageBuilder: (_, a1, a2) => FlutterStopWatch());

        return null;
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.deepPurple,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.blue
              : Colors.blue),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url1 = "https://smobx1.github.io/lcb_json_test.json";
  List data1;
  int defaultNoViews = 50;
  int rewardForAdViewed = 5;
  Future<String> retreivedDate;
  Future<String> retreivedViewsRemaining;
  int totalViewsNrShow = 0;

  RewardedVideoAd videoAd = RewardedVideoAd.instance;

  calculateTimeRemaining() {
    String remainingDays = '100';
    String retreivedDate = data1[0]['dataExamen'];
    final examDate = DateTime.parse(retreivedDate);
    final currentDate = DateTime.now();
    final difference = currentDate.difference(examDate).inDays;
    String differenceString = difference.toString();
    differenceString = differenceString.substring(1);

    return differenceString;
  }

  Future<int> getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');

    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> decrementViewsNr() async {
    final prefs = await SharedPreferences.getInstance();
    int lastStartupNumber = await getIntFromSharedPref();
    int currentStartupNumber;
    if (lastStartupNumber > 0) {
      currentStartupNumber = lastStartupNumber - 1;
    } else if (currentStartupNumber == null) {
      currentStartupNumber = 0;
    }

    await prefs.setInt('startupNumber', currentStartupNumber);

    defaultNoViews = currentStartupNumber;
  }

  Future<void> incrementTotalViewsEverNr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }

  Future<void> resetViewsNr() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startupNumber', 50);

    setState(() => defaultNoViews = 50);
  }

  //TODO implement watchAd and give the reward (rewardForAdViewed)
  Future<void> showAd() async {
    print('show ad');
    RewardedVideoAd.instance.show();
  }

  Future<void> watchAd(int reward) async {
    final prefs = await SharedPreferences.getInstance();
    int lastStartupNumber = await getIntFromSharedPref();
    int currentStartupNumber = reward + lastStartupNumber;

    await prefs.setInt('startupNumber', currentStartupNumber);

    setState(() => defaultNoViews = currentStartupNumber);

    viewsAddedAlert(context);
  }

  loadAd() {
    print('load ad');
    RewardedVideoAd.instance.load(adUnitId: RewardedVideoAd.testAdUnitId);
  }

  Future<void> setInitialViewsNr() async {
    final prefs = await SharedPreferences.getInstance();

    // set sharedPref (viewsNo) to the default value
    // runs only the first time
    if (prefs.containsKey('startupNumber')) {
      /// do nothing
    } else {
      await prefs.setInt('startupNumber', defaultNoViews);
      setState(() => defaultNoViews = defaultNoViews);
    }
  }

  Future<String> getViewsNr() async {
    final prefs = await SharedPreferences.getInstance();
    int lastStartupNumber = await getIntFromSharedPref();
    int currentStartupNumber = lastStartupNumber;

    await prefs.setInt('startupNumber', currentStartupNumber);

    setState(() => defaultNoViews = currentStartupNumber);
  }

  Future<String> getTotalViewsEverNr() async {
    final prefs = await SharedPreferences.getInstance();
    int tempCurrentCounter = prefs.getInt('counter');
    if (tempCurrentCounter == null) {
      setState(() => totalViewsNrShow = 0);
    } else {
      setState(() => totalViewsNrShow = tempCurrentCounter);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();

    retreivedDate = getJsonData();

    /// runs only if the sharedPreferences (views nr) hasn't been instanciated
    this.setInitialViewsNr();

    /// retreives current nr of views remaining
    this.getViewsNr();
    this.getTotalViewsEverNr();

    var stopwatch = new Stopwatch()..start();
    setState(() {
      print(stopwatch);
    });

    print('Homepage INIT called');

    /// admob INIT
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print('REWARDED VIDEO AD $event');
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          watchAd(rewardAmount);
        });
      } else if (event == RewardedVideoAdEvent.closed) {
        loadAd();
        print('load when closed');
      }
    };

    /// load the ad for the first time (then load() is called onClosed
    loadAd();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
      // Encode the URL
      Uri.encodeFull(url1),
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
      data1 = convertDataToJson['altele'];
    });
    return "Success";
  }

  Data app_data = Data();

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timeInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
    }

    void startTimer() {
      timer = Timer.periodic(timeInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.blue,
        ),
        title: Text('Liceu cu Brio'),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 2.0 : 0.0,
        leading: Container(),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<String>(
              future: retreivedDate,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    calculateTimeRemaining().toString() +
                        ' de zile pana la BAC!',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  );
                } else if (snapshot.hasError) {
                  // if it doesn't bring back any data
                  return Text("");
                } else {
                  return Text("...");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                //TODO: fa timer pe lectii si baga l aici
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 85.0,
                    lineWidth: 10.0,
                    percent: 0.10,
                    center: new Text("1"),
                    progressColor: Colors.red,
                    header: Text('# ore'),
                  ),
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 85.0,
                    lineWidth: 10.0,
                    percent: 0.10,
                    center: new Text("1" + "/10"),
                    progressColor: Colors.red,
                    header: Text('Medie estimata'),
                  ),
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 85.0,
                    lineWidth: 10.0,
                    percent: 0.10,
                    center: new Text(totalViewsNrShow.toString()),
                    progressColor: Colors.red,
                    header: Text('# vizualizari'),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(
                'Stopwatch',
              ),
              onTap: () async {
                Navigator.pushNamed(context, "/stopwatch");
              },
            ),
            ListTile(
              title: Text(
                'Vizualizari ramase: ' + defaultNoViews.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: showAd,
                textColor: Colors.white,
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Vezi Reclama'),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 24,
                      ),
                    ),
                    Text(
                      '+ 5 vizualizari',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Termeni si conditii',
              ),
              onTap: () async {
                Navigator.pushNamed(context, "/terms");
              },
            ),
            ListTile(
              title: Text(
                'Testing audio',
              ),
              onTap: () async {
                Navigator.pushNamed(context, "/testingAudio");
              },
            ),
            ListTile(
              title: Text(
                'Testing audio 2',
              ),
              onTap: () async {
                Navigator.pushNamed(context, "/testingAudio2");
              },
            ),
            ListTile(
              title: Text(
                'Testing ADS',
              ),
              onTap: () async {
                Navigator.pushNamed(context, "/testingads");
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          /// pages
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new PremiumPage('Premium')));
                      },
                      color: Colors.white,
                      child: Text(
                        'Premium',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Tutors()));
                      },
                      color: Colors.white,
                      child: Text(
                        'Anunturi Meditatii',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Statistics()));
                      },
                      color: Colors.white,
                      child: Text(
                        'Statistics',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// audio lessons
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 60,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new MyApp()));
                      },
                      color: Colors.white,
                      child: Text('Lectii Audio'),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// cursuri
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Course(
                                // trimit map cu cursul si map cu lectiile
                                app_data.course1,
                                app_data.c1_lessons)));
                      },
                      color: Colors.white,
                      child: Text(app_data.course1['name']),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Course(
                                // sending the MAPs<> with Course & Lessons data
                                app_data.course2,
                                app_data.c2_lessons)));
                      },
                      color: Colors.white,
                      child: Text(app_data.course2['name']),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Mate M1'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Mate M2'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Istorie'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Geografie'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Biologie Vegetala'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Biologie Anatomie'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Psihologie'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Logica'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Sociologie'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Text('Filosofie'),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 60,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new SimplePage(app_data.help_page)));
                      },
                      color: Colors.white,
                      child: Text(
                        'Help',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 60,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Testing()));
                      },
                      color: Colors.white,
                      child: Text(
                        'Testing Page',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
