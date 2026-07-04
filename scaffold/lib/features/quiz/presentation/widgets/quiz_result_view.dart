import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/quiz_result.dart';

class QuizResultView extends StatelessWidget {
  const QuizResultView({required this.result, super.key});

  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final percent = (result.score * 100).round();
    final passed = result.passed;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: scheme.inverseSurface,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                passed ? Icons.check_rounded : Icons.close_rounded,
                size: 52,
                color: scheme.onInverseSurface,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              passed ? 'Passed' : 'Not quite',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              passed
                  ? 'Great work — you cleared this one.'
                  : 'Review the material and try again.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            _ScoreRow(percent: percent, result: result),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.goNamed('library'),
                child: const Text('Back to Library'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({required this.percent, required this.result});

  final int percent;
  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outline),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: _Stat(value: '$percent%', label: 'Score')),
            VerticalDivider(width: 1, color: scheme.outline),
            Expanded(
              child: _Stat(
                value: '${result.correct}/${result.total}',
                label: 'Correct',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(label, style: theme.textTheme.labelMedium),
      ],
    );
  }
}
