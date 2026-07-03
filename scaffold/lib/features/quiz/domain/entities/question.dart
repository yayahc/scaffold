import 'package:equatable/equatable.dart';

class AnswerOption extends Equatable {
  const AnswerOption({
    required this.id,
    required this.label,
    required this.correct,
  });

  final String id;
  final String label;
  final bool correct;

  @override
  List<Object?> get props => [id, label, correct];
}

sealed class Question extends Equatable {
  const Question({required this.id, required this.prompt});

  final String id;
  final String prompt;

  bool isCorrect(Object? answer);

  @override
  List<Object?> get props => [id, prompt];
}

class SingleChoiceQuestion extends Question {
  const SingleChoiceQuestion({
    required super.id,
    required super.prompt,
    required this.options,
  });

  final List<AnswerOption> options;

  @override
  bool isCorrect(Object? answer) {
    final correct = options.firstWhere((o) => o.correct).id;
    return answer == correct;
  }

  @override
  List<Object?> get props => [...super.props, options];
}

class MultiChoiceQuestion extends Question {
  const MultiChoiceQuestion({
    required super.id,
    required super.prompt,
    required this.options,
  });

  final List<AnswerOption> options;

  @override
  bool isCorrect(Object? answer) {
    if (answer is! Set<String>) return false;
    final correct = options.where((o) => o.correct).map((o) => o.id).toSet();
    return answer.length == correct.length && answer.containsAll(correct);
  }

  @override
  List<Object?> get props => [...super.props, options];
}

class TrueFalseQuestion extends Question {
  const TrueFalseQuestion({
    required super.id,
    required super.prompt,
    required this.answer,
  });

  final bool answer;

  @override
  bool isCorrect(Object? given) => given == answer;

  @override
  List<Object?> get props => [...super.props, answer];
}
