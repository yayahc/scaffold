import '../entities/quiz.dart';
import '../entities/quiz_result.dart';

class GradeQuiz {
  const GradeQuiz();

  QuizResult call(Quiz quiz, Map<String, Object?> answers) {
    final correct = quiz.questions
        .where((q) => q.isCorrect(answers[q.id]))
        .length;
    return QuizResult(
      total: quiz.questions.length,
      correct: correct,
      passThreshold: quiz.passThreshold,
    );
  }
}
