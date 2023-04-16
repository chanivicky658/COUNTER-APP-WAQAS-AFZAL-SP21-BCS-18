import 'package:flutter/material.dart';
import 'multiple_choice_quiz_page.dart';
import 'true_false_quiz_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,

      home: QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.brown,

      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('True False'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => TrueFalseQuizPage()));
              },
            ),
            ListTile(
              title: Text('Multiple Choice Questions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleChoiceQuizPage()));
              },
            ),
          ],
        ),
      ),

      body: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
        image: AssetImage("assets/quizwaqas.jpg"),
    fit: BoxFit.cover,
    ),
    ),

    ),


    );
  }
}
