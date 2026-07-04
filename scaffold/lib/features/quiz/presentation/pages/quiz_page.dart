import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../progress/domain/usecases/record_quiz_attempt.dart';
import '../../domain/entities/quiz.dart';
import '../cubit/quiz_cubit.dart';
import '../widgets/question_view.dart';
import '../widgets/quiz_result_view.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({
    required this.quiz,
    required this.title,
    required this.contentId,
    super.key,
  });

  final Quiz quiz;
  final String title;
  final String contentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          QuizCubit(
            quiz: quiz,
            contentId: contentId,
            recordAttempt: getIt<RecordQuizAttempt>(),
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
        ),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state.isFinished) {
              return QuizResultView(result: state.result!);
            }
            final theme = Theme.of(context);
            final cubit = context.read<QuizCubit>();
            final total = state.quiz.questions.length;
            final answered = state.answers[state.currentQuestion.id] != null;
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: (state.index + 1) / total,
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'QUESTION ${state.index + 1} OF $total',
                          style: theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: QuestionView(
                        question: state.currentQuestion,
                        selected: state.answers[state.currentQuestion.id],
                        onChanged: (value) =>
                            cubit.answer(state.currentQuestion.id, value),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                    child: Row(
                      children: [
                        if (state.index > 0) ...[
                          Expanded(
                            child: OutlinedButton(
                              onPressed: cubit.previous,
                              child: const Text('Back'),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          flex: state.index > 0 ? 1 : 2,
                          child: FilledButton(
                            onPressed: answered
                                ? (state.isLastQuestion
                                    ? cubit.submit
                                    : cubit.next)
                                : null,
                            child: Text(
                                state.isLastQuestion ? 'Submit' : 'Next'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
