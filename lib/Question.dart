class Question {
  String _question;
  bool _answer;

  Question({String q, bool ans}) {
    this._question = q;
    this._answer = ans;
  }

  bool get answer => _answer;

  String get question => _question;
}
