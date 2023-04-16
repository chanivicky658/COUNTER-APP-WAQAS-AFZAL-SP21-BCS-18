import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MyXylophoneApp());
}

class MyXylophoneApp extends StatefulWidget {
  @override
  _MyXylophoneAppState createState() => _MyXylophoneAppState();
}

class _MyXylophoneAppState extends State<MyXylophoneApp> {
  int _numberOfButtons = 7;
  List<Color> _buttonColors = List.generate(7, (index) => Colors.green);
  List<Widget> _buttons = [];
  List<Audio> _sounds = [
    Audio("assets/note1.wav"),
    Audio("assets/note2.wav"),
    Audio("assets/note3.wav"),
    Audio("assets/note4.wav"),
    Audio("assets/note5.wav"),
    Audio("assets/note6.wav"),
    Audio("assets/note7.wav"),
  ];
  int _numberOfSounds = 7;
  List<int> _selectedSounds = List.generate(7, (index) => 0);

  void playSound(int number) {
    final player = AssetsAudioPlayer();
    player.open(_sounds[_selectedSounds[number - 1]]);
  }

  Expanded createButton(int number, String buttonText, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          playSound(number);
        },
        child: Text(buttonText),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
      ),
    );
  }

  void updateButtons() {
    _buttons.clear();
    for (int i = 0; i < _numberOfButtons; i++) {
      _buttons.add(
        Row(
          children: [
            createButton(i + 1, " ", _buttonColors[i]),
            SizedBox(width: 25.0),
            buildColorDropdownButton(i),
            SizedBox(width: 25.0),
            buildSoundDropdownButton(i),
          ],
        ),
      );
    }
  }

  List<Widget> generateButtons() {
    if (_buttons.isEmpty) {
      updateButtons();
    }
    return _buttons;
  }

  DropdownMenuItem<Color> buildColorItem(Color color) {
    return DropdownMenuItem(
      value: color,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,

        ),
        width: 30.0,
        height: 30.0,
      ),
    );
  }


  DropdownButton<Color> buildColorDropdownButton(int index) {
    return DropdownButton<Color>(
      value: _buttonColors[index],
      onChanged: (value) {
        setState(() {
          _buttonColors[index] = value!;
          updateButtons();
        });
      },
      items: Colors.primaries.map((color) {
        return buildColorItem(color);
      }).toList(),
    );
  }

  DropdownMenuItem<Audio> buildSoundItem(int index) {
    return DropdownMenuItem(
      value: _sounds[index],
      child: Text("Sound ${index + 1}"),
    );
  }

  DropdownButton<Audio> buildSoundDropdownButton(int index) {
    return DropdownButton<Audio>(
      value: _sounds[_selectedSounds[index]],
      onChanged: (value) {
        setState(() {
          _selectedSounds[index] = _sounds.indexOf(value!);
          updateButtons();
        });
      },
      items: List.generate(_numberOfSounds, (index) {
        return buildSoundItem(index);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Expanded(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text("Waqas Xylophone App"),

              centerTitle: true,

              actions: [
                PopupMenuButton<int>(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Colors"),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Text("1"),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text("2"),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text("3"),
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: Text("4"),
                        value: 4,
                      ),
                      PopupMenuItem(
                        child: Text("5"),
                        value: 5,
                      ),
                      PopupMenuItem(
                        child: Text("6"),
                        value: 6,
                      ),
                      PopupMenuItem(
                        child: Text("7"),
                        value: 7,
                      ),
                    ];
                  },
                  onSelected: (value) {
                    setState(() {
                      _numberOfButtons = value;
                      updateButtons();
                    });
                  },
                )
              ],

            ),
            body: Container(
              decoration: BoxDecoration(
                color: Color(0xFF3B1111), // Replace with your desired background color
              ),

              child: TabBarView(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: generateButtons(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      DropdownButton<Color>(
                        value: _buttonColors[0],
                        onChanged: (value) {
                          setState(() {
                            _buttonColors[0] = value!;
                          });
                        },
                        items: Colors.primaries.map((color) {
                          return buildColorItem(color);
                        }).toList(),
                      ),
                      DropdownButton<Color>(
                        value: _buttonColors[1],
                        onChanged: (value) {
                          setState(() {
                            _buttonColors[1] = value!;
                          });
                        },
                        items: Colors.primaries.map((color) {
                          return buildColorItem(color);
                        }).toList(),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

