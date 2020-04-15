import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furrytinder/profile.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Future<List<Pet>> pets;

  Future<List<Pet>> fetchPets() async {
    final response = await http.get('https://v1.api-trevl.eu/app/furry_tinder/pets.json');

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      List<Pet> _pets = [];
      json.forEach((petJson) {
        Pet pet = Pet.fromJson(petJson);
        _pets.add(pet);
      });

      return _pets;
    }
  }

  @override
  void initState() {
    super.initState();
    pets = fetchPets();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _getBodyWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Pets')),
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('Chat')),
        ],
      ),
    );
  }

  Widget _getBodyWidget() {
    if (_selectedIndex == 0) {
      return _getPets();
    } else if (_selectedIndex == 1) {
      return _getChatWidget();
    }
  }

  Widget _getPets() {
    return FutureBuilder<List<Pet>>(
      future: pets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _getListView(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(
          child: CircularProgressIndicator()
        );
      },
    );
  }

  ListView _getListView(List<Pet> _pets) {
//    Map<String, Pet> pets = {
//      "john": Pet(
//        "John",
//        6,
//        true,
//        'https://images.theconversation.com/files/304244/original/file-20191128-178107-9wucox.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop',
//        0,
//        ['Sniffing', 'Digging', 'Running'],
//        'Soulmate',
//      ),
//      "rex": Pet(
//        "Rex",
//        2,
//        false,
//        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/best-dog-quotes-1580508958.jpg?crop=0.670xw:1.00xh;0.167xw,0&resize=640:*',
//        2,
//        ['Roling in mud', 'Eating', 'Slobbering'],
//        'The one',
//      ),
//      "max": Pet(
//        "Max",
//        7,
//        true,
//        'https://images.theconversation.com/files/319652/original/file-20200310-61148-vllmgm.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=754&fit=clip',
//        12,
//        ['Chilling', 'Barking', 'Ignoring humans'],
//        'Something casual',
//      ),
//    };
    return ListView.builder(
      padding: new EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i < _pets.length) {
          Pet pet = _pets[i];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            clipBehavior: Clip.hardEdge,
            elevation: 3,
            child: InkWell(
              splashColor: Colors.grey.withAlpha(50),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProfilePage.route,
                  arguments: pet,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Row(
                    children: <Widget>[
                      Hero(
                          tag: 'petAvatar' + pet.name,
                          child: Image.network(
                            pet.avatar,
                            repeat: ImageRepeat.noRepeat,
                            scale: 1,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width,
                            height: 256,
                          ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        child: Text(
                          pet.name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                      )
                    ],
//                    )
//                  ],
              ),
            )
          );
        }
        return null;
      }
    );
  }

  Widget _getChatWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              '😥',
              style: TextStyle(
                fontSize: 48,
              ),
            ),
          ),
          Text(
            'You haven\'t chatted with anyone yet!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54
            ),
          ),
        ],
      ),
    );
  }

  ListView _getChatList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (context, i) {
        return null;
      }
    );
  }
}

class Pet {
  String _name;
  int _age;
  bool _fluffy;
  String _avatar;
  int _children;
  List<dynamic> _hobbies;
  String _goal;

  Pet(this._name, this._age, this._fluffy, this._avatar, this._children, this._hobbies, this._goal);

  factory Pet.fromJson(dynamic json) {
    return Pet(
      json['name'],
      json['age'],
      json['fluffy'],
      json['avatar'],
      json['children'],
      json['hobbies'],
      json['goal'],
    );
  }

  get name {
    return _name;
  }

  get age {
    return _age;
  }

  get fluffy {
    return _fluffy;
  }

  get avatar {
    return _avatar;
  }

  get children {
    return _children;
  }

  get hobbies {
    return _hobbies;
  }

  get goal {
    return _goal;
  }
}
