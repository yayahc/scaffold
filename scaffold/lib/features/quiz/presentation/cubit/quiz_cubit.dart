import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../progress/domain/usecases/record_quiz_attempt.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/quiz.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/usecases/grade_quiz.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit({
    required Quiz quiz,
    required String contentId,
    required RecordQuizAttempt recordAttempt,
    GradeQuiz grade = const GradeQuiz(),
  })  : _contentId = contentId,
        _recordAttempt = recordAttempt,
        _grade = grade,
        super(QuizState(quiz: _shuffled(quiz)));

  static Quiz _shuffled(Quiz quiz) {
    if (!quiz.random) return quiz;
    final questions = [...quiz.questions]..shuffle();
    return Quiz(
      questions: questions,
      passThreshold: quiz.passThreshold,
      random: quiz.random,
    );
  }

  final String _contentId;
  final RecordQuizAttempt _recordAttempt;
  final GradeQuiz _grade;

  void answer(String questionId, Object? value) {
    if (state.revealed.contains(questionId)) return;
    final answers = Map<String, Object?>.from(state.answers)
      ..[questionId] = value;
    emit(state.copyWith(
      answers: answers,
      revealed: {...state.revealed, questionId},
    ));
  }

  void next() {
    if (state.index < state.quiz.questions.length - 1) {
      emit(state.copyWith(index: state.index + 1));
    }
  }

  void previous() {
    if (state.index > 0) emit(state.copyWith(index: state.index - 1));
  }

  void submit() {
    final result = _grade(state.quiz, state.answers);
    emit(state.copyWith(result: result));
    // Persist the attempt (completed + best score); fire-and-forget.
    unawaited(
      _recordAttempt(
        RecordQuizAttemptParams(
          contentId: _contentId,
          score: result.score,
          attemptedAt: DateTime.now(),
        ),
      ),
    );
  }
}
