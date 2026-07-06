part of 'quiz_cubit.dart';

class QuizState extends Equatable {
  const QuizState({
    required this.quiz,
    this.index = 0,
    this.answers = const {},
    this.revealed = const {},
    this.result,
  });

  final Quiz quiz;
  final int index;
  final Map<String, Object?> answers;
  final Set<String> revealed;

  final QuizResult? result;

  Question get currentQuestion => quiz.questions[index];
  bool get isLastQuestion => index == quiz.questions.length - 1;
  bool get isFinished => result != null;

  bool get isCurrentRevealed => revealed.contains(currentQuestion.id);

  bool get isCurrentAnswered {
    final answer = answers[currentQuestion.id];
    if (answer == null) return false;
    if (answer is Set) return answer.isNotEmpty;
    return true;
  }

  QuizState copyWith({
    int? index,
    Map<String, Object?>? answers,
    Set<String>? revealed,
    QuizResult? result,
  }) {
    return QuizState(
      quiz: quiz,
      index: index ?? this.index,
      answers: answers ?? this.answers,
      revealed: revealed ?? this.revealed,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [quiz, index, answers, revealed, result];
}
