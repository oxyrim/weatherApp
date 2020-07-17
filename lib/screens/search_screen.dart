import 'package:flutter/material.dart';

class SearchLocation extends StatefulWidget {
  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  String newLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/seachBg.JPG'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context); //go back to weather display screen
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Enter location',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      )),
                  onChanged: (value) {
                    newLocation = value;
                    //print(newLocation);
                  },
                ),
              ),
              FlatButton(
                color: Colors.white10,
                onPressed: () {
                  Navigator.pop(context, newLocation);
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                    fontSize: 30.0,
                    //fontFamily: 'Pacifico',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
