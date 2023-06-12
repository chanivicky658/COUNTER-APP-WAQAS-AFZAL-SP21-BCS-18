import 'package:flutter/material.dart';
import 'package:ludo_flutter/main_screen.dart';
import 'package:ludo_flutter/main_screen2.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'custom.dart';
import 'ludo_provider.dart';
import 'twoplayer.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LudoProvider()),
        ChangeNotifierProvider(create: (_) => two_player()),
      ],
      child: Root(),
    ),
  );
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool _imagesPrecached = false;

  @override
  void didChangeDependencies() {
    if (!_imagesPrecached) {
      /// Initialize images and precache them
      precacheImage(const AssetImage("assets/images/thankyou.gif"), context);
      precacheImage(const AssetImage("assets/images/board.png"), context);
      precacheImage(const AssetImage("assets/images/dice/1.png"), context);
      precacheImage(const AssetImage("assets/images/dice/2.png"), context);
      precacheImage(const AssetImage("assets/images/dice/3.png"), context);
      precacheImage(const AssetImage("assets/images/dice/4.png"), context);
      precacheImage(const AssetImage("assets/images/dice/5.png"), context);
      precacheImage(const AssetImage("assets/images/dice/6.png"), context);
      precacheImage(const AssetImage("assets/images/dice/draw.gif"), context);
      precacheImage(const AssetImage("assets/images/crown/1st.png"), context);
      precacheImage(const AssetImage("assets/images/crown/2nd.png"), context);
      precacheImage(const AssetImage("assets/images/crown/3rd.png"), context);

      setState(() {
        _imagesPrecached = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}






class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/next': (context) => NextScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
          () {
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/bg.jpg'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset('assets/img/logo.png', height: 250, width: 250), // Replace with your game logo image path
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
          () {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6F35A5),
      body:


      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 140, bottom: 100, left: 10),
              child: Container(
                color: Color(0xFF6F35A5),
                child: Image.asset(
                  'assets/img/hs1.png', // Replace with your logo image path
                  height: 300, // Set the desired height
                  width: 400, // Set the desired width
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                color: Color(0xFF6F35A5),
                child: _isLoading
                    ? SpinKitThreeInOut(
                  color: Colors.black54,
                  size: 50.0,
                )
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    backgroundColor: Colors.black, // Set the background color
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/next');
                  },
                  child: Text(
                    'Play',
                    style: TextStyle(
                      color: Colors.white, // Set the text color
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  bool isAudioMuted = false;
  bool isVibrationOn = true;

  void toggleAudio() {
    setState(() {
      isAudioMuted = !isAudioMuted;
    });
  }

  void toggleVibration() {
    setState(() {
      isVibrationOn = !isVibrationOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: IconButton(
            onPressed: () {
              // Handle friends button pressed
            },
            icon: Icon(Icons.people),
          ), // Replace with your profile picture asset
        ),
        title: Text('Khaaala LUDO'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Handle friends button pressed
            },
            icon: Icon(Icons.people),
          ),
          IconButton(
            onPressed: () {
              // Handle settings button pressed
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Icon(
                            isAudioMuted ? Icons.volume_off : Icons.volume_up,
                          ),
                          title: Text(isAudioMuted ? 'Unmute Audio' : 'Mute Audio'),
                          onTap: () {
                            Navigator.pop(context); // Close the bottom sheet
                            toggleAudio(); // Toggle audio state
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            isVibrationOn ? Icons.vibration : Icons.vibration,
                          ),
                          title: Text(isVibrationOn ? 'Vibration On' : 'Vibration Off'),
                          onTap: () {
                            Navigator.pop(context); // Close the bottom sheet
                            toggleVibration(); // Toggle vibration state
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/gradient.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [

                Column(
                  children: [ Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => fourScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 21),
                            child: Container(
                              height: 140,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Image.asset('assets/img/hs.png'),
                                    ),
                                  ),
                                  Text(
                                    '2 Players',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 140,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Image.asset('assets/img/hs.png'),
                                    ),
                                  ),
                                  Text(
                                    '4 Players',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),],
                  ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 130),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainScreen()),
                                  );
                                },
                                child: Container(
                                  height: 130,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.pink.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 90,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 18),
                                          child: Image.asset('assets/img/hs.png'),
                                        ),
                                      ),
                                      Text(
                                        'Team Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainScreen()),
                                  );
                                },
                                child: Container(
                                  height: 130,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.pink.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 90,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 18),
                                          child: Image.asset('assets/img/hs.png'),
                                        ),
                                      ),
                                      Text(
                                        'Offline',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainScreen()),
                                  );
                                },
                                child: Container(
                                  height: 130,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.pink.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 90,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 18),
                                          child: Image.asset('assets/img/hs.png'),
                                        ),
                                      ),
                                      Text(
                                        'Play With Friends',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainScreen()),
                                  );
                                },
                                child: Container(
                                  height: 130,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.pink.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 90,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 18),
                                          child: Image.asset('assets/img/hs.png'),
                                        ),
                                      ),
                                      Text(
                                        'Tournament',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),

                    ),
                  ],
                ),




              ],
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                // Handle rewards button pressed
              },
              icon: Icon(Icons.card_giftcard),
            ),
            IconButton(
              onPressed: () {
                // Handle dice button pressed
              },
              icon: Icon(Icons.casino),
            ),
          ],
        ),
      ),
    );
  }
}





