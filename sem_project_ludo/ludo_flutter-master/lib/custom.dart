import 'package:flutter/material.dart';
import 'ludo_provider.dart';
import 'main_screen.dart';
import 'twoplayer.dart';

class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Select Player',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w800,
              letterSpacing: 5,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/custompage.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              // Add spacing between the buttons

                  SizedBox(height: 25), // Add spacing between the buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle button 3 press
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 46, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    icon: Icon(
                      Icons.people,
                      size: 30,
                    ),
                    label: Text(
                      'Four Player',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
