import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/question.dart';
import '../../domain/entities/quiz.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/usecases/grade_quiz.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit({required Quiz quiz, GradeQuiz grade = const GradeQuiz()})
      : _grade = grade,
        super(QuizState(quiz: quiz));

  final GradeQuiz _grade;

  void answer(String questionId, Object? value) {
    final answers = Map<String, Object?>.from(state.answers)
      ..[questionId] = value;
    emit(state.copyWith(answers: answers));
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
  }
}
