import 'package:flutter/material.dart';
import './Quiz.dart';
import './quizList.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int activeQuizIndex = 0;
  List<Widget> scoreKeeper = new List();
  Quiz activeQuiz;

  static final Icon successIcon = Icon(
    Icons.check,
    color: Colors.green,
  ),
      failedIcon = Icon(
    Icons.close,
    color: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    activeQuiz = quizes[activeQuizIndex];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                activeQuiz.questionBank[activeQuiz.activeQuestion].question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(questionResult: true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(questionResult: false);
              },
            ),
          ),
        ),
        Wrap(
          children: scoreKeeper,
        ),
      ],
    );
  }

  /* Function */
  void checkAnswer({questionResult}) {
    if (activeQuiz.complete) {
      Alert(
        context: context,
        title: "Quiz complete!",
        buttons: <DialogButton>[
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
              resetQuiz();
            },
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ],
      ).show();
      return;
    }

    Icon newIcon = questionResult ==
            activeQuiz.questionBank[activeQuiz.activeQuestion].answer
        ? successIcon
        : failedIcon;

    setState(() {
      scoreKeeper.add(newIcon);
    });

    loadNextQuestion();
  }

  void loadNextQuestion() {
    setState(() {
      activeQuiz.increaseActiveQuestionByOne();
    });
  }

  void resetQuiz() {
    setState(() {
      activeQuiz.resetQuiz();
      scoreKeeper.clear();
    });
  }
}
