import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furrytinder/home.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key key,
    @required this.pet,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static const route = '/profile';
  final Pet pet;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.pet.name),
//      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Hero(
            tag: 'petAvatar' + widget.pet.name,
            child: Image.network(
              widget.pet.avatar,
              repeat: ImageRepeat.noRepeat,
              scale: 1,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(widget.pet.name),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text(widget.pet.age.toString()),
          ),
          ListTile(
            leading: Icon(Icons.child_friendly),
            title: Text(widget.pet.children.toString()),
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text(widget.pet.hobbies.join(', ')),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text(widget.pet.goal),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton.icon(
              onPressed: () {
                print('Pressed the chat button');
              },
              icon: Icon(Icons.message),
              label: Container(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Start chatting with ' + widget.pet.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              elevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))
              ),
              color: Colors.red[400],
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}