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
        super(QuizState(quiz: quiz));

  final String _contentId;
  final RecordQuizAttempt _recordAttempt;
  final GradeQuiz _grade;

  void answer(String questionId, Object? value) {
    if (state.revealed.contains(questionId)) return;
    final answers = Map<String, Object?>.from(state.answers)
      ..[questionId] = value;
    emit(state.copyWith(answers: answers));
  }

  void reveal() {
    final id = state.currentQuestion.id;
    if (state.revealed.contains(id)) return;
    emit(state.copyWith(revealed: {...state.revealed, id}));
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
