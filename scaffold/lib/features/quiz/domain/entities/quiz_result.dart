import 'package:equatable/equatable.dart';

class QuizResult extends Equatable {
  const QuizResult({
    required this.total,
    required this.correct,
    required this.passThreshold,
  });

  final int total;
  final int correct;
  final double passThreshold;

  double get score => total == 0 ? 0 : correct / total;

  bool get passed => score >= passThreshold;

  @override
  List<Object?> get props => [total, correct, passThreshold];
}
