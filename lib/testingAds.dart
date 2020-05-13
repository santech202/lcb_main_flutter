import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestingAds extends StatefulWidget {
  @override
  _TestingAdsState createState() => _TestingAdsState();
}

const testDevices = "Your Device ID";

class _TestingAdsState extends State<TestingAds> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevices != null ? <String>['testDevices'] : null,
    // keywords: <String>['Book', 'Game'],
    nonPersonalizedAds: true,
  );

  int coins = 0;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print('REWARDED VIDEO AD $event');
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          coins = coins + rewardAmount;
        });
      }
    };

    _getCheckBox();
    _getCheckBox1();
  }

  showAd() {
    print('show ad');
    RewardedVideoAd.instance.show();
  }

  loadAd() {
    print('load ad');
    RewardedVideoAd.instance.load(adUnitId: RewardedVideoAd.testAdUnitId);
  }

  _saveCheckBox(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isChecked', status);
  }

  _saveCheckBox1(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isChecked1', status);
  }

  _getCheckBox() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool getChecked = prefs.getBool('isChecked');
    if (getChecked != null) {
      setState(() {
        checkBoxValue = getChecked;
      });
    }
  }

  _getCheckBox1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool getChecked = prefs.getBool('isChecked1');
    if (getChecked != null) {
      setState(() {
        checkBoxValue1 = getChecked;
      });
    }
  }

  bool checkBoxValue = false;
  bool checkBoxValue1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('titlu'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Show'),
              onPressed: () {
                showAd();
              },
            ),
            RaisedButton(
              child: Text('Load'),
              onPressed: () {
                loadAd();
              },
            ),
            Text('You have $coins coins'),
            Checkbox(
                value: checkBoxValue,
                onChanged: (bool value) {
                  print(value);
                  setState(() {
                    checkBoxValue = value;
                    _saveCheckBox(value);
                  });
                }),
            Checkbox(
                value: checkBoxValue1,
                onChanged: (bool value) {
                  print(value);
                  setState(() {
                    checkBoxValue1 = value;
                    _saveCheckBox1(value);
                  });
                })
          ],
        ),
      ),
    );
  }
}
