import 'package:equatable/equatable.dart';

import 'question.dart';

class Quiz extends Equatable {
  const Quiz({
    required this.questions,
    this.passThreshold = 0.7,
    this.shuffle = false,
  });

  final List<Question> questions;

  final double passThreshold;

  final bool shuffle;

  factory Quiz.fromPayload(Map<String, dynamic> payload) {
    final rawQuestions = (payload['questions'] as List? ?? const []);
    return Quiz(
      passThreshold: (payload['passThreshold'] as num?)?.toDouble() ?? 0.7,
      shuffle: payload['shuffle'] as bool? ?? false,
      questions: rawQuestions
          .cast<Map<String, dynamic>>()
          .map(_questionFromJson)
          .toList(),
    );
  }

  static Question _questionFromJson(Map<String, dynamic> j) {
    final id = j['id'] as String;
    final prompt = j['prompt'] as String;
    switch (j['kind'] as String) {
      case 'single':
        return SingleChoiceQuestion(
          id: id,
          prompt: prompt,
          options: _options(j),
        );
      case 'multi':
        return MultiChoiceQuestion(
          id: id,
          prompt: prompt,
          options: _options(j),
        );
      case 'truefalse':
        return TrueFalseQuestion(
          id: id,
          prompt: prompt,
          answer: j['answer'] as bool,
        );
      default:
        throw ArgumentError('Unknown question kind: ${j['kind']}');
    }
  }

  static List<AnswerOption> _options(Map<String, dynamic> j) {
    return (j['options'] as List)
        .cast<Map<String, dynamic>>()
        .map((o) => AnswerOption(
              id: o['id'] as String,
              label: o['label'] as String,
              correct: o['correct'] as bool? ?? false,
            ))
        .toList();
  }

  @override
  List<Object?> get props => [questions, passThreshold, shuffle];
}
