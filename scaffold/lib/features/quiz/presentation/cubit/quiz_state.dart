part of 'quiz_cubit.dart';

class QuizState extends Equatable {
  const QuizState({
    required this.quiz,
    this.index = 0,
    this.answers = const {},
    this.result,
  });

  final Quiz quiz;
  final int index;
  final Map<String, Object?> answers;

  /// Null until the quiz is submitted and graded.
  final QuizResult? result;

  Question get currentQuestion => quiz.questions[index];
  bool get isLastQuestion => index == quiz.questions.length - 1;
  bool get isFinished => result != null;

  QuizState copyWith({
    int? index,
    Map<String, Object?>? answers,
    QuizResult? result,
  }) {
    return QuizState(
      quiz: quiz,
      index: index ?? this.index,
      answers: answers ?? this.answers,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [quiz, index, answers, result];
}
