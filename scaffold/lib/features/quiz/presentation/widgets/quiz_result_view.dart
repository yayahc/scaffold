import 'package:flutter/material.dart';

import '../../domain/entities/quiz_result.dart';

class QuizResultView extends StatelessWidget {
  const QuizResultView({required this.result, super.key});

  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    final percent = (result.score * 100).round();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            result.passed ? Icons.check_circle : Icons.cancel,
            size: 72,
            color: result.passed ? Colors.green : Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            result.passed ? 'Passed' : 'Try again',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text('$percent%  ·  ${result.correct}/${result.total} correct'),
        ],
      ),
    );
  }
}
