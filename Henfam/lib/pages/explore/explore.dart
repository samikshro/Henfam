import 'package:Henfam/pages/explore/currentOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './lilMode.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  void _switchToBig() {
    Navigator.pushNamed(context, '/bigmode');
  }

  final _activities = const [
    {
      'picture': Image(
        image: AssetImage('assets/activity1.png'),
      ),
      'caption': 'Getting Food from Collegetown',
    },
    {
      'picture': Image(
        image: AssetImage('assets/activity2.png'),
      ),
      'caption': 'Getting Food from Campus',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // LocationEggScore(score: _score, location: _location),
                  // LilBigSwitch(_switchToLil, _switchToBig),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Run an Errand",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _switchToBig,
                  ),
                  CurrentOrders(),
                ],
              ),
              LilMode(_activities)
            ],
          ),
        ),
      ),
    );
  }
}
