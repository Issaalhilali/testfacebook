import 'package:flutter/material.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/services.dart';
import 'package:testadsfacebook/adsservice.dart';

import 'second.dart';
import 'dart:io';

Future main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isInterstitialAdLoaded = false;
  final ads = AdsService();
  @override
  void initState() {
    super.initState();

    FacebookAudienceNetwork.init(
        testingId: "b9f2908b-1a6b-4a5b-b862-ded7ce289e41");
    ads.loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('second'),
              onPressed: () {
                ads.showInterstitialAd();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Second()));
              },
            ),
            ads.showBannerAd(),
            // ads.showBannerAd(),
          ],
        ),
      ),
    );
  }
}
