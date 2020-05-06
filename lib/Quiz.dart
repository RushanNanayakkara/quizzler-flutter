import 'package:quizzler/Question.dart';

class Quiz {
  List<Question> _questionBank;
  int _activeQuestion;
  bool _complete;

  Quiz([List<Question> questionList = const []]) {
    this._questionBank = questionList;
    this._activeQuestion = 0;
    this._complete = questionList.length == 0;
  }

  List<Question> get questionBank => _questionBank;

  int get activeQuestion => _activeQuestion;

  bool get complete => _complete;

  void increaseActiveQuestionByOne() {
    _complete = _activeQuestion >= questionBank.length - 1;
    if (!_complete) _activeQuestion++;
  }

  void resetQuiz() {
    _activeQuestion = 0;
    _complete = false;
  }
}
